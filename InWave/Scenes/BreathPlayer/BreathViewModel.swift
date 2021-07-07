//
//  BreathViewModel.swift
//  InWave
//
//  Created by Laurent Droguet on 15/11/2020.
//

import SwiftUI
import Combine
import Core
import Common

final class BreathViewModel: ObservableObject, Identifiable {
    // MARK: - ViewState
    enum ViewStep {
        case notStarted
        case countdown
        case started
        case finished
        
        func hasFinished() -> Bool {
            if case .finished = self { return true } else { return false }
        }
        
        func hasCountdown() -> Bool {
            if case .countdown = self { return true } else { return false }
        }
        
        func hasNotStarted() -> Bool {
            if case .notStarted = self { return true } else { return false }
        }
    }
    
    // MARK: - Outputs
    
    /// View steps
    @Published var viewStep: ViewStep = .notStarted {
        didSet {
            switch viewStep {
            case .started:
                startBreathing()
            case .countdown:
                startCountdown()
            default: break
            }
        }
    }
    /// Breath title : ex : "coherence cardiac"
    let breathTitle: String
    /// Text showing the current cycle on the total number of cycles - ex: cycle 09 / 30
    @Published var cycleText: String = ""
    /// Breath symbol - 0 : inhale, 1: hold, 2 : exhale, 3 : hold
    @Published var breathSymbolIndex: Int = 0
    /// Breath symbols available
    var breathSymbolIndexAvailable: [Int] = []
    /// On the countdown step, show the countdown : "3, 2, 1, go"
    @Published var countdownText: String = ""
    /// Name of the current breath action - ex: "Inspirez"
    @Published var currentBreathAction: String = ""
    /// Time remaining for current breath action
    @Published var currentBreathActionTimeRemaining: String = ""
    var breathTotalDurationText: String = ""
    /// Breath duration text
    @Published var breathTimeProgressText: String  = ""//"00:00"
    /// Breath time remaining
    @Published var breathTimeProgressValue: Double  = 0
    /// Breath player is playing
    @Published var breathPlayerIsPlaying: Bool = true
    /// Music player is playing
    @Published var musicPlayerIsPlaying: Bool = true
    /// Wave animation
    @Published var waveAnimation: (WaveAnimationType, CGFloat) = (.idleLow, 1)
    
    // MARK: - Private properties
    // Injected
    let breath: Breath
    private var userRepository: UserRepositoryContract
    private var breathEngine: BreathEngine
    private var player: InWavePlayer!

    // Local
    private var breathTimer: Timer?
    private var countdownTimer: Timer?
    private lazy var feedbackGenerator: UIImpactFeedbackGenerator = {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        return feedbackGenerator
    }()
    
    // Utilities
    private var upperBounds = 0
    private var currentCycle = 1
    private var totalSeconds = -1
    
    init(breath: Breath, dependencies: DependenciesContainer = AppDependencies.container) {
        self.userRepository = dependencies.resolve()
        self.breath = breath
        self.breathEngine = BreathEngine(breath: breath)
        
        upperBounds = breathEngine.getCurrentManoeuverDuration()
        breathTitle = breath.name
        breathTotalDurationText = formatNumber(breath.configuration.duration)
        
        breathSymbolIndexAvailable = configureBreathSymbolsAvailable(breath: breath)
        
        DispatchQueue.global().async {
            self.player = InWavePlayer(breath: breath)
            self.setupPlayer()
        }
        
        cycleText = "CYCLE 01 / \(breath.configuration.cycleNumber.formatStringWith0())"
    }
    
    deinit {
        breathTimer?.invalidate()
        countdownTimer?.invalidate()
        player.stopMusic()
    }
}

// MARK: - Countdown
private extension BreathViewModel {
    func startCountdown() {
        countdownText = "3"
        totalSeconds += 1
        player.play(.countdownStart)

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.totalSeconds += 1
            self.countdownText = String(3 - self.totalSeconds)
            if self.totalSeconds == 3 {
                self.countdownText = "Go"
                self.player.play(.countdownEnd)
                return
            }
            else if self.totalSeconds == 4 {
                self.countdownTimer?.invalidate()
                self.totalSeconds = -1
                self.viewStep = .started
                return
            }
            self.player.play(.countdownStart)
        }
    }
}

// MARK: - Start breathing
private extension BreathViewModel {
    func startBreathing() {
        breathPlayerIsPlaying = true
        emitManoeuvers()
        player.play(self.breathEngine.getCurrentAudio())
    }
    
    func emitManoeuvers() {
        manoeuverLogic()
        feedbackGenerator.impactOccurred()
        
        breathTimer = nil
        breathTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.manoeuverLogic()
        }
    }
    
    func manoeuverLogic() {
        // Increment totalSeconds
        self.totalSeconds += 1
        // End session if beyond breath total duration
        guard self.totalSeconds < self.breath.configuration.duration else {
            finishSession()
            return
        }
        
        updateBreathManoeuverIfNeeded()
        
        waveAnimation = (WaveAnimationType.convert(from: breathEngine.currentManoeuver),
                         2 / CGFloat(breathEngine.getCurrentManoeuverDuration()))
        currentBreathAction = self.breathEngine.currentManoeuver.getTitle()
        currentBreathActionTimeRemaining = String(self.upperBounds - self.totalSeconds) + "s"
        breathTimeProgressText = self.formatNumber(self.totalSeconds)
        
        breathTimeProgressValue = Double(self.totalSeconds) / Double(self.breath.configuration.duration)
        
        switch breathEngine.currentManoeuver {
        case .inhale:
            breathSymbolIndex = 1
        case .inHaleHold:
            breathSymbolIndex = 2
        case .exhale:
            breathSymbolIndex = 3
        case .exhaleHold:
            breathSymbolIndex = 4
        }
    }

    func updateBreathManoeuverIfNeeded() {
        if self.totalSeconds == upperBounds {
            feedbackGenerator.impactOccurred()
            breathEngine.nextManoeuver()
            player.play(self.breathEngine.getCurrentAudio())
            // Update cycle if needed
            if case .inhale = breathEngine.currentManoeuver {
                currentCycle += 1
                cycleText = "CYCLE " +
                    currentCycle.formatStringWith0()
                    + " / "
                    + breath.configuration.cycleNumber.formatStringWith0()
            }
            upperBounds += breathEngine.getCurrentManoeuverDuration()
        }
    }
}

// MARK: - Finished
private extension BreathViewModel {
    func finishSession() {
        breathTimer?.invalidate()
        userRepository.totalSessionNumber += 1
        userRepository.totalDailyTime += self.breath.configuration.duration
        breathTimeProgressValue = 1
        viewStep = .finished
        player.stopMusic()
    }
}

// MARK: - Player setup
private extension BreathViewModel {
    func setupPlayer() {
        DispatchQueue.main.async {
            self.musicPlayerIsPlaying = !self.userRepository.isMusicmuted
        }
        
        if !userRepository.isMusicmuted {
            self.player.play(.beach)
        }
    }
}

// MARK: - Inputs
extension BreathViewModel {
    func tooglePlayer() {
        if breathPlayerIsPlaying {
            breathTimer?.invalidate()
        } else {
            emitManoeuvers()
        }
        breathPlayerIsPlaying.toggle()
    }
    
    func toogleMusic() {
        player.toogleMusic()
        userRepository.isMusicmuted = !player.musicIsPlaying()
        musicPlayerIsPlaying.toggle()
    }
}

// MARK: - Utilities
private extension BreathViewModel {
    func formatNumber(_ number: Int) -> String {
        let minutes = Int(number / 60) < 10 ? "0\(Int(number / 60))" : "\(Int(number / 60))"
        let seconds = number % 60 < 10 ? "0\(number%60)" : "\(number%60)"
        return minutes + ":" + seconds
    }
    
    func configureBreathSymbolsAvailable(breath: Breath) -> [Int] {
        var array: [Int] = []
        if breath.configuration.inhale > 0 { array.append(1) }
        if breath.configuration.inHaleHold > 0 { array.append(2) }
        if breath.configuration.exhale > 0 { array.append(3) }
        if breath.configuration.exhaleHold > 0 { array.append(4) }
        return array
    }
}

extension Int {
    func formatStringWith0() -> String {
        (self < 10 ? "0\(self)" : "\(self)")
    }
}

extension Bundle {
    func safePath(forResource: String?) -> String {
        guard let path = Bundle.main.path(forResource: forResource, ofType: nil) else { fatalError() }
        return path
    }
}
