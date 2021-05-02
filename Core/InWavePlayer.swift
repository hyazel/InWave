//
//  InWavePlayer.swift
//  InWave
//
//  Created by Laurent Droguet on 08/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import AVFoundation
import Common

public final class InWavePlayer {
    public enum Audio {
        case exhale(duration: Int)
        case inhale(duration: Int)
        case hold(duration: Int)
        
        case beach
        
        case countdownStart
        case countdownEnd
    }
    
    private static var musicPlayer: AVAudioPlayer = AVAudioPlayer()
    private var breathPlayer: AVAudioPlayer = AVAudioPlayer()
    private var longInhaleBreathPlayer: AVAudioPlayer = AVAudioPlayer()
    private var longExhaleBreathPlayer: AVAudioPlayer = AVAudioPlayer()
    private var countDownPlayer: AVAudioPlayer = AVAudioPlayer()
//    private static var musicPlayerIsPlaying: Bool = false
    
    public init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            
        }
    }
    
    func loadMusicBeach() {
        do {
            Self.musicPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "music-beach.mp3")))
            Self.musicPlayer.prepareToPlay()
            Self.musicPlayer.numberOfLoops = -1
        } catch {
            print("player init failed")
        }
    }
    
    func loadCountdownStart() {
        do {
            countDownPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "chrono_1.mp3")))
            countDownPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadCountdownEnd() {
        do {
            countDownPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "chrono_2.mp3")))
            countDownPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathInhale() {
        do {
            breathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "Inspi_son_bref.mp3")))
            breathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathExhale() {
        do {
            breathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "expir_son_bref.mp3")))
            breathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathHold() {
        do {
            breathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "stop_son_bref.mp3")))
            breathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathLongExhale(duration: Int) {
        do {
            longExhaleBreathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "pads2_exp_\(duration)s.mp3")))
            longExhaleBreathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathLongInhale(duration: Int) {
        do {
            longInhaleBreathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "pads2_insp_\(duration)s.mp3")))
            longExhaleBreathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    public func play(_ audio: Audio) {
        switch audio {
        case .beach:
            loadMusicBeach()
            Self.musicPlayer.play()
            Self.musicPlayer.volume = 0.05
        case .inhale(let duration):
            loadBreathInhale()
            breathPlayer.play()
            breathPlayer.volume = 0.05
            loadBreathLongInhale(duration: duration)
            longInhaleBreathPlayer.play()
            longInhaleBreathPlayer.volume = 0.05
        case .exhale(let duration):
            loadBreathExhale()
            breathPlayer.play()
            breathPlayer.volume = 0.05
            loadBreathLongExhale(duration: duration)
            longExhaleBreathPlayer.play()
            longExhaleBreathPlayer.volume = 0.05
        case .hold:
            loadBreathHold()
            breathPlayer.volume = 0.05
            breathPlayer.play()
        case .countdownStart:
            loadCountdownStart()
            countDownPlayer.play()
            countDownPlayer.volume = 0.05
        case .countdownEnd:
            loadCountdownEnd()
            countDownPlayer.play()
            countDownPlayer.volume = 0.05
        }
    }
    
    public func toogleMusic() {
        if Self.musicPlayer.isPlaying {
            Self.musicPlayer.setVolume(0, fadeDuration: 0.5)
            Self.musicPlayer.pause()
        } else {
            Self.musicPlayer.play()
            Self.musicPlayer.setVolume(0.05, fadeDuration: 2)
        }
    }
    
    public func musicIsPlaying() -> Bool {
        Self.musicPlayer.isPlaying
    }
    
    public func stopMusic() {
        Self.musicPlayer.setVolume(0, fadeDuration: 2)
    }
}

extension Bundle {
    func safePath(forResource: String?) -> String {
        guard let path = Bundle.main.path(forResource: forResource, ofType: nil) else { fatalError() }
        return path
    }
}
