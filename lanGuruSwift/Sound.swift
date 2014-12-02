//
//  Sound.swift
//  lanGuruSwift
//
//  Created by Iman Sheikholmolouki on 02/12/14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import Foundation
import AVFoundation

class Sound : NSObject {
    
    /// The player.
    var audioPlayer:AVAudioPlayer!
   
    // read a file into the AVPlayer
    func readFileIntoAVPlayer(fileName : NSString, withType fileType : NSString) {
        
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType) {
            self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path), fileTypeHint: fileType, error: nil)
        }
        
    }
    
    // shared instance which is used by all apps, request the shared instance right before you start playing
    func setSessionPlayer() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayback, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    
    func playSoundWithVolume(volume : Float) {
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.volume = volume
        self.setSessionPlayer()
        self.audioPlayer.play()
    }
    
    func stopAVPLayer() {
        if self.audioPlayer.playing {
            self.audioPlayer.stop()
        }
    }
    
    func toggleAVPlayer() {
        if self.audioPlayer.playing {
            self.audioPlayer.pause()
        } else {
            self.audioPlayer.play()
        }
    }
}

