//
//  LGPostGameViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGPostGameViewController: UIViewController {
    
    @IBOutlet weak var localUserProfilePictureView: UIImageView!
    @IBOutlet weak var opponentProfilePictureImageView: UIImageView!
    
    @IBOutlet weak var localUserNameLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    @IBOutlet weak var localUserScoreLabel: UILabel!
    @IBOutlet weak var opponentScoreLabel: UILabel!
    
    @IBOutlet weak var localUserMinusScoreLabel: UILabel!
    @IBOutlet weak var opponentMinusScoreLabel: UILabel!
    
    @IBOutlet weak var localUserScorePercentLabel: UILabel!
    @IBOutlet weak var opponentUserScorePercentLabel: UILabel!
    
    @IBOutlet weak var localPlayerRankingLabel: UILabel!
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    
    var match : Match?
    var matchResult : Match?
    
    let localUser : User = User.getLocalUser()
    let matchClient : LGMatchClient = LGMatchClient.self()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //setup statusbar
        var profilePictureImageData = NSData(base64EncodedString: match!.opponentProfilePic, options: .allZeros)
        self.opponentProfilePictureImageView.image = UIImage(data:profilePictureImageData!)
        self.opponentProfilePictureImageView.layer.cornerRadius = self.opponentProfilePictureImageView.frame.size.height/2
        self.opponentProfilePictureImageView.clipsToBounds = true
        self.opponentNameLabel.text = (self.localUser.username == self.match!.opponent1 ? self.match!.opponent2 : self.match!.opponent1)
        
        profilePictureImageData = NSData(base64EncodedString: localUser.profilePicture, options: .allZeros)
        self.localUserProfilePictureView.image = UIImage(data:profilePictureImageData!)
        self.localUserProfilePictureView.layer.cornerRadius = self.localUserProfilePictureView.frame.size.height/2
        self.localUserProfilePictureView.clipsToBounds = true
        self.localUserNameLabel.text = self.localUser.username
        
        self.localUserScoreLabel.text = (self.localUser.username == self.matchResult!.opponent1 ? "\(self.matchResult!.score1)" : "\(self.matchResult!.score2)")
        self.opponentScoreLabel.text = (self.localUser.username == self.matchResult!.opponent1 ? "\(self.matchResult!.score2)" : "\(self.matchResult!.score1)")
        

        let minusScoreLocalUser : Int = (self.localUser.username == self.matchResult!.opponent1 ? self.matchResult!.result1.componentsSeparatedByString("0").count : self.matchResult!.result2.componentsSeparatedByString("0").count)
        let minusScoreOpponent : Int = (self.localUser.username == self.matchResult!.opponent1 ? self.matchResult!.result2.componentsSeparatedByString("0").count : self.matchResult!.result1.componentsSeparatedByString("0").count)
        self.localUserMinusScoreLabel.text = "\(minusScoreLocalUser-1)"
        self.opponentMinusScoreLabel.text = "\(minusScoreOpponent-1)"
        
        let localPlayerHasWon = (self.localUser.username == self.matchResult!.opponent1 && self.matchResult!.score1 > self.matchResult!.score2) || (self.localUser.username == self.matchResult!.opponent2 && self.matchResult!.score2 > self.matchResult!.score1)
        self.gameStatusLabel.text = localPlayerHasWon ? "Gewonnen" : "Verloren"
        self.gameStatusLabel.textColor = localPlayerHasWon ? UIColor(red: 5/255.0, green: 176/255.0, blue: 147/255.0, alpha: 1.0) : UIColor(red: 219/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
        
        self.localPlayerRankingLabel.text = (self.localUser.username == self.matchResult!.opponent1 ? "\(self.matchResult!.ranking1)" : "\(self.matchResult!.ranking2)")
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    //@Felix: to do: make sure match is closed if there is no internet connection
    @IBAction func backButtonPressed(sender: AnyObject)
    {
        let matchDictionary : [String : AnyObject] = ["id": self.match!.identity]
        self.matchClient.closeMatch(matchDictionary)

        let previousViewController : UIViewController = self.navigationController!.viewControllers[0] as UIViewController
        self.navigationController!.popToViewController(previousViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
