//
//  LGMatchAcceptPopoverView.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 05.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGMatchAcceptPopoverView: UIView {
    
    @IBOutlet weak var localUserProfilePicture: UIImageView!
    @IBOutlet weak var opponentProfilePicture: UIImageView!
    
    @IBOutlet weak var localUserNameLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    var delegate:LGMatchRequestPopoverDelegate! = nil
    var matchRequestID : Int = 0
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func closeButtonPressed(sender: AnyObject)
    {
        self.removeFromSuperview()
    }
   
    @IBAction func acceptMatchRequest(sender: AnyObject)
    {
        self.removeFromSuperview()
        self.delegate.acceptMatchRequest(matchRequestID)
    }
  
    @IBAction func declineMatchRequest(sender: AnyObject)
    {
    
    }
}
