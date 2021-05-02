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
    enum ViewState {
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
    
    // Outputs
    @Published var viewState: ViewState = .notStarted {
        didSet {
            switch viewState {
            case .started:
                startBreathing()
            case .countdown:
                startCountdown()
            default: break
            }
        }
    }
    @Published var cycle: String = ""
    @Published var countdownTime: String = ""
    @Published var manoeuver: String = ""
    @Published var manoeuverTime: String = ""
    @Published var currentText: String  = "00:00"
    @Published var currentNumber: Double  = 0
    @Published var isPlaying: Bool = true
    @Published var isMusicPlaying: Bool = true
    @Published var strokeWidth: Double = 1
    @Published var waveAnimation: (WaveAnimationType, CGFloat) = (.idleLow, 1)
    @Published var breathSymbolIndex: Int = 1
    var breathSymbolIndexAvailable: [Int] = []
    
    let breathTitle: String
    var totalTime: String = ""
    
    // MARK: - Private properties
    // Injected
    private var breath: Breath
    private var userRepository: UserRepositoryContract
    private var breathEngine: BreathEngine
    private let player: InWavePlayer = InWavePlayer()

    // Local
    private var breathTimer: Timer?
    private var countdownTimer: Timer?
    private lazy var feedbackGenerator: UIImpactFeedbackGenerator = {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        return feedbackGenerator
    }()
    private var disposables = Set<AnyCancellable>()
    
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
        totalTime = formatNumber(breath.configuration.duration)
        
        breathSymbolIndexAvailable = configureBreathSymbolsAvailable(breath: breath)
        
        setupPlayer()
        
        cycle = "CYCLE 01 / \(breath.configuration.cycleTotalNumber.formatStringWith0())"
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
        countdownTime = "3"
        totalSeconds += 1
        player.play(.countdownStart)
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.totalSeconds += 1
            self.countdownTime = String(3 - self.totalSeconds)
            if self.totalSeconds == 3 {
                self.countdownTime = "Go"
                self.player.play(.countdownEnd)
                return
            }
            else if self.totalSeconds == 4 {
                self.countdownTimer?.invalidate()
                self.totalSeconds = -1
                self.viewState = .started
                return
            }
            self.player.play(.countdownStart)
        }
    }
}

// MARK: - Start breathing
private extension BreathViewModel {
    func startBreathing() {
        isPlaying = true
        strokeWidth = 5
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
        print("totalSeconds \(totalSeconds)")
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
        manoeuver = self.breathEngine.currentManoeuver.getTitle()
        manoeuverTime = String(self.upperBounds - self.totalSeconds) + "s"
        currentText = self.formatNumber(self.totalSeconds)
        currentNumber = Double(self.totalSeconds) / Double(self.breath.configuration.duration)

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
    // 2 1
    // 5
    func updateBreathManoeuverIfNeeded() {
        if self.totalSeconds == upperBounds {
            feedbackGenerator.impactOccurred()
            breathEngine.nextManoeuver()
            player.play(self.breathEngine.getCurrentAudio())
            strokeWidth = 5
            // Update cycle if needed
            if case .inhale = breathEngine.currentManoeuver {
                currentCycle += 1
                cycle = "CYCLE " +
                    currentCycle.formatStringWith0()
                    + " / "
                    + breath.configuration.cycleTotalNumber.formatStringWith0()
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
        currentNumber = 1
        viewState = .finished
        player.toogleMusic()
    }
}

// MARK: - Player setup
private extension BreathViewModel {
    func setupPlayer() {
        isMusicPlaying = !userRepository.isMusicmuted
        if !userRepository.isMusicmuted {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.player.play(.beach)
            }
        }
    }
}

// MARK: - Inputs
extension BreathViewModel {
    func tooglePlayer() {
        if isPlaying {
            breathTimer?.invalidate()
        } else {
            emitManoeuvers()
        }
        isPlaying.toggle()
    }
    
    func toogleMusic() {
        player.toogleMusic()
        userRepository.isMusicmuted = !player.musicIsPlaying()
        isMusicPlaying.toggle()
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

