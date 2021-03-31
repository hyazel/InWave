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
    
    private var musicPlayer: AVAudioPlayer = AVAudioPlayer()
    private var breathPlayer: AVAudioPlayer = AVAudioPlayer()
    private var longInhaleBreathPlayer: AVAudioPlayer = AVAudioPlayer()
    private var longExhaleBreathPlayer: AVAudioPlayer = AVAudioPlayer()
    private var countDownPlayer: AVAudioPlayer = AVAudioPlayer()
    
    public init() {
        musicPlayer.numberOfLoops = -1
        
        longExhaleBreathPlayer.volume = 0.6
    }
    
    func loadMusicBeach() {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "music-beach.mp3")))
            musicPlayer.prepareToPlay()
            musicPlayer.volume = 0
        } catch {
            print("player init failed")
        }
    }
    
    func loadCountdownStart() {
        do {
            countDownPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "chrono_1.mp3")))
            countDownPlayer.prepareToPlay()
            countDownPlayer.volume = 0.7
        } catch {
            print("player init failed")
        }
    }
    
    func loadCountdownEnd() {
        do {
            countDownPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "chrono_2.mp3")))
            countDownPlayer.prepareToPlay()
            countDownPlayer.volume = 0.7
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
            longExhaleBreathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "pads2_insp_\(duration)s.mp3")))
            longExhaleBreathPlayer.prepareToPlay()
            longExhaleBreathPlayer.volume = 0.6
        } catch {
            print("player init failed")
        }
    }
    
    func loadBreathLongInhale(duration: Int) {
        do {
            longInhaleBreathPlayer = try AVAudioPlayer(contentsOf: URL(safeString: Bundle.main.safePath(forResource: "pads2_exp_\(duration)s.mp3")))
            longExhaleBreathPlayer.prepareToPlay()
            longInhaleBreathPlayer.volume = 0.6
        } catch {
            print("player init failed")
        }
    }
    
    public func play(_ audio: Audio) {
        switch audio {
        case .beach:
            loadMusicBeach()
            musicPlayer.play()
            musicPlayer.setVolume(0.7, fadeDuration: 4)
        case .inhale(let duration):
            loadBreathInhale()
            breathPlayer.play()
            loadBreathLongInhale(duration: duration)
            longInhaleBreathPlayer.play()
        case .exhale(let duration):
            loadBreathExhale()
            breathPlayer.play()
            loadBreathLongExhale(duration: duration)
            longExhaleBreathPlayer.play()
        case .hold:
            loadBreathHold()
            breathPlayer.play()
        case .countdownStart:
            loadCountdownStart()
            countDownPlayer.play()
        case .countdownEnd:
            loadCountdownEnd()
            countDownPlayer.play()
        }
    }
    
    public func toogleMusic() {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            musicPlayer.setVolume(0, fadeDuration: 2)
        } else {
            musicPlayer.play()
            musicPlayer.setVolume(0.7, fadeDuration: 2)
        }
    }
    
    public func musicIsPlaying() -> Bool {
        musicPlayer.isPlaying
    }
}

extension Bundle {
    func safePath(forResource: String?) -> String {
        guard let path = Bundle.main.path(forResource: forResource, ofType: nil) else { fatalError() }
        return path
    }
}
