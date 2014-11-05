//
//  LGMatchRequestPopoverView.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 05.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGMatchRequestPopoverView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate:LGMatchRequestPopoverDelegate! = nil
    var matchRequestID : Int = 0
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBAction func closeButtonPressed(sender: AnyObject)
    {
        self.removeFromSuperview()

    }
    
    @IBAction func enterGameButtonPressed(sender: AnyObject)
    {
        self.delegate.enterGame(matchRequestID)
    }
}
