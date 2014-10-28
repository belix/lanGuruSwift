//
//  LGMatchmakingAnimatingView.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit
import QuartzCore

class LGMatchmakingAnimatingView: UIView {

    var currentTag : Int = 1
    var stopAnimating : Bool = false
    
    func startAnimatingDots() {
        stopAnimating = false
        self.animatingDot()
    }
    
    func animatingDot(){
        var currentDot : UIView = self.viewWithTag(currentTag)!
        currentDot.layer.transform = CATransform3DMakeScale(0.1,0.1,1)

        UIView.animateWithDuration(0.5, delay: 0.0, options: nil, animations: {
                currentDot.layer.transform = CATransform3DMakeScale(1,1,1)
            },
            completion: { finished in
                var tag : Int = self.currentTag
                self.currentTag = max(((tag+1) % 7),1)
                if !self.stopAnimating{
                    self.animatingDot()
            }
        })
    }
    
    func endAnimatingDots() {
        stopAnimating = true
    }

}
