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
    
    /**
    Uses AvAudioPlayer to play a sound file.
    The player instance needs to be an instance variable. Otherwise it will disappear before playing.
    */
    
    
    func readFileIntoAVPlayer(fileName : NSString, withType fileType : NSString) {
        
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType) {
            self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path), fileTypeHint: fileType, error: nil)
        }
        
    }
    
    func playSoundWithVolume(volume : Float) {
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.volume = volume
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

