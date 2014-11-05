//
//  LGMatchmakingViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGMatchmakingViewController: UIViewController {

    @IBOutlet weak var matchmakingAnimatingView: LGMatchmakingAnimatingView!
    
    @IBOutlet weak var localUserCoverPictureImageView: UIImageView!
    @IBOutlet weak var opponentCoverPictureImageView: UIImageView!
    
    @IBOutlet weak var localUserProfilePictureImageView: UIImageView!
    @IBOutlet weak var opponentProfilePictureImageView: UIImageView!
    
    @IBOutlet weak var opponentView: UIView!
    
    @IBOutlet weak var localUserNameLabel: UILabel!
    @IBOutlet weak var opponentNameLabel: UILabel!
    
    
    let localUser : User = User.getLocalUser()
    let matchmakingClient : LGMatchmakingClient = LGMatchmakingClient.self()
    var currentMatch : Match?
    
    var searchingForFriend : Bool = false
    var isAccepter : Bool = false
    var searchingFriendMatchID : NSInteger = 0
    var searchingStatus : Int = 0
    var isAsynchronousGame : Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let coverImageData = NSData(base64EncodedString: localUser.coverPicture, options: .allZeros)
        self.localUserCoverPictureImageView.image = UIImage(data:coverImageData!)

        let profilePictureImageData = NSData(base64EncodedString: localUser.profilePicture, options: .allZeros)
        self.localUserProfilePictureImageView.image = UIImage(data:profilePictureImageData!)
        self.localUserProfilePictureImageView.layer.cornerRadius = self.localUserProfilePictureImageView.frame.size.height/2
        self.localUserProfilePictureImageView.clipsToBounds = true

        
        self.localUserNameLabel.text = localUser.username;
        
       // self.startSearchingForOpponent()
        
        matchmakingAnimatingView.startAnimatingDots()
        
        if self.searchingForFriend
        {
            if self.isAccepter
            {
                self.searchingStatus = 1
            }
            self.startSearchingForFriend()
        }
        else
        {
            self.startSearchingForOpponent()
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func startSearchingForOpponent()
    {
        matchmakingClient.searchForOpponentForUser(localUser){ (match) -> Void in
            
            if match != nil
            {
                self.currentMatch = match as? Match
                self.setupOpponentInterface()
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("pushToGame"), userInfo: nil, repeats: false)
            }
            else
            {
                //Felix : to do: make weakself
                self.startSearchingForOpponent()
            }
        }
    }
    
    func startSearchingForFriend()
    {
        matchmakingClient.challengeFriendForMatch(self.searchingFriendMatchID, andStatus:self.searchingStatus){ (match) -> Void in
            
            if match != nil
            {
                self.currentMatch = match as? Match
                
                if self.currentMatch!.status == 2 || self.currentMatch!.status == 3
                {
                    self.isAsynchronousGame = true
                }
                
                self.setupOpponentInterface()
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("pushToGame"), userInfo: nil, repeats: false)
            }
            else
            {
                //Felix : to do: make weakself
                self.startSearchingForFriend()
            }
        }
    }
    
    @IBAction func startGameButtonPressed(sender: AnyObject)
    {
        //change searching status to 2 (challengerPlayed)
        self.searchingStatus = 2
        self.isAsynchronousGame = true
    }
    
    func pushToGame()
    {
        self.performSegueWithIdentifier("showGame", sender: nil)

    }
    
    func setupOpponentInterface()
    {
        let coverImageData = NSData(base64EncodedString: self.currentMatch!.opponentCoverPic, options: .allZeros)
        self.opponentCoverPictureImageView.image = UIImage(data:coverImageData!)
        self.opponentCoverPictureImageView.hidden = false

        let profilePictureImageData = NSData(base64EncodedString: self.currentMatch!.opponentProfilePic, options: .allZeros)
        self.opponentProfilePictureImageView.image = UIImage(data:profilePictureImageData!)
        self.opponentProfilePictureImageView.layer.cornerRadius = self.opponentProfilePictureImageView.frame.size.height/2
        self.opponentProfilePictureImageView.clipsToBounds = true
        
        self.opponentNameLabel.text = (self.localUser.username == self.currentMatch!.opponent1 ? self.currentMatch!.opponent2 : self.currentMatch!.opponent1)
        
        self.opponentView.hidden = false
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showGame"{
            var destinationViewController : LGGamingViewController = segue.destinationViewController as LGGamingViewController
            destinationViewController.match = self.currentMatch
            destinationViewController.isAsynchronousGame = self.isAsynchronousGame
            destinationViewController.hidesBottomBarWhenPushed = true;
        }
    }
}
