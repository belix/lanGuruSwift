//
//  LGMatchFinishedPopoverView.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 05.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGMatchFinishedPopoverView: UIView {

    @IBOutlet weak var localUserProfilePicture: UIImageView!
    @IBOutlet weak var opponentProfilePicture: UIImageView!
    
    @IBOutlet weak var localUserNameLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gamePointsLabel: UILabel!
    
    var delegate:LGMatchRequestPopoverDelegate! = nil
    
    @IBAction func closeButtonPressed(sender: AnyObject)
    {
        self.removeFromSuperview()
    }

    @IBAction func playAgain(sender: AnyObject)
    {

    }
    
    func setupViewsForMatchLocalUserAndOpponent(match : Match, localUser : User, opponent : User)
    {
        
        let localUserScore : Int = (localUser.userID == match.opponent1UserID ? match.score1 : match.score2)

        let opponentUserScore : Int = (localUser.userID == match.opponent1UserID ? match.score2 : match.score1)
        let localPlayerHasWon = localUserScore > opponentUserScore

        self.descriptionLabel.text = localPlayerHasWon ? "Gewonnen" : "Verloren"
        self.descriptionLabel.textColor = localPlayerHasWon ? UIColor(red: 5/255.0, green: 176/255.0, blue: 147/255.0, alpha: 1.0) : UIColor(red: 219/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
        
        self.gamePointsLabel.text = String(format: "%i - %i", localUserScore, opponentUserScore)
        
        self.localUserNameLabel.text = localUser.username;
        self.localUserProfilePicture.image = localUser.getProfilePictureImage()
        
        self.localUserProfilePicture.layer.cornerRadius = self.localUserProfilePicture.frame.size.height/2
        self.localUserProfilePicture.clipsToBounds = true
        
        self.opponentNameLabel.text = opponent.username;
        self.opponentProfilePicture.image = opponent.getProfilePictureImage()
        
        self.opponentProfilePicture.layer.cornerRadius = self.opponentProfilePicture.frame.size.height/2
        self.opponentProfilePicture.clipsToBounds = true
    }
}
