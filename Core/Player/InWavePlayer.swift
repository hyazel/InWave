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
        static var generalVolume: Float = 0.5
        case exhale(duration: Int)
        case inhale(duration: Int)
        case hold(duration: Int)
        
        case beach
        
        case countdownStart
        case countdownEnd
    }
    
    private static var musicPlayer: AVAudioPlayer!
    private static var breathPlayer: AVAudioPlayer!
    private static var longInhaleBreathPlayer: AVAudioPlayer!
    private static var longExhaleBreathPlayer: AVAudioPlayer!
    private static var countDownPlayer: AVAudioPlayer!
    private static var countDownEndPlayer: AVAudioPlayer!
    private var breath: Breath? = nil
    
    public init(breath: Breath? = nil) {
        self.breath = breath
        bufferAudio()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {

        }
    }
    
    func bufferAudio() {
        loadMusicBeach()
        loadBreathHold()
        loadCountdownStart()
        loadCountdownEnd()
        loadBreathInhale()
        loadBreathExhale()
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
            Self.countDownPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "chrono_1.mp3")))
            Self.countDownPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadCountdownEnd() {
        do {
            Self.countDownEndPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "chrono_2.mp3")))
            Self.countDownEndPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathInhale() {
        do {
            Self.breathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "Inspi_son_bref.mp3")))
            Self.breathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathExhale() {
        do {
            Self.breathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "expir_son_bref.mp3")))
            Self.breathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathHold() {
        do {
            Self.breathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "stop_son_bref.mp3")))
            Self.breathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathLongExhale(duration: Int) {
        do {
            Self.longExhaleBreathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "pads2_exp_\(duration)s.mp3")))
            Self.longExhaleBreathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathLongInhale(duration: Int) {
        do {
            Self.longInhaleBreathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "pads2_insp_\(duration)s.mp3")))
            Self.longInhaleBreathPlayer.prepareToPlay()
        } catch {
            print("player init failed")
        }
    }
    
    public func play(_ audio: Audio) {
        DispatchQueue.global(qos: .userInitiated).sync {
            switch audio {
            case .beach:
                loadMusicBeach()
                Self.musicPlayer.play()
                Self.musicPlayer.volume = Audio.generalVolume
            case .inhale(let duration):
                loadBreathInhale()
                Self.breathPlayer.play()
                Self.breathPlayer.volume = Audio.generalVolume
                
                loadBreathLongInhale(duration: duration)
                Self.longInhaleBreathPlayer.play()
                Self.longInhaleBreathPlayer.volume = Audio.generalVolume
            case .exhale(let duration):
                loadBreathExhale()
                Self.breathPlayer.play()
                Self.breathPlayer.volume = Audio.generalVolume
                
                loadBreathLongExhale(duration: duration)
                Self.longExhaleBreathPlayer.play()
                Self.longExhaleBreathPlayer.volume = Audio.generalVolume
            case .hold:
                loadBreathHold()
                Self.breathPlayer.volume = Audio.generalVolume
                Self.breathPlayer.play()
            case .countdownStart:
                Self.countDownPlayer.play()
                Self.countDownPlayer.volume = Audio.generalVolume
            case .countdownEnd:
                Self.countDownEndPlayer.play()
                Self.countDownEndPlayer.volume = Audio.generalVolume
            }
        }
    }
    
    public func toogleMusic() {
        if Self.musicPlayer.isPlaying {
            Self.musicPlayer.setVolume(0, fadeDuration: 0.5)
            Self.musicPlayer.pause()
        } else {
            Self.musicPlayer.play()
            Self.musicPlayer.setVolume(Audio.generalVolume, fadeDuration: 2)
        }
    }
    
    public func musicIsPlaying() -> Bool {
        Self.musicPlayer.isPlaying
    }
    
    public func stopMusic() {
        Self.musicPlayer.setVolume(0, fadeDuration: 1)
        
        if Self.longExhaleBreathPlayer != nil {
            Self.longExhaleBreathPlayer.setVolume(0, fadeDuration: 1)
        }
        if Self.longInhaleBreathPlayer != nil {
            Self.longInhaleBreathPlayer.setVolume(0, fadeDuration: 1)
        }
    }
}

extension Bundle {
    func safePath(forResource: String?) -> String {
        guard let path = Bundle.main.path(forResource: forResource, ofType: nil) else { fatalError() }
        return path
    }
}
