//
//  SoundManager.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 5.08.25.
//

import Foundation
import AVKit

class SoundManager {
    static let shared = SoundManager()
    
    private init() {}
    
    var player: AVAudioPlayer?
    func playSound(named:String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = 1.0
            player?.play()
            print("played")
        }
        catch {
            print("Error playing sound: \(error)")
        }
    }
}
