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
    let localUser : User = User.getLocalUser()
    let matchmakingClient : LGMatchmakingClient = LGMatchmakingClient.self()
    var currentMatch : Match?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coverImageData = NSData(base64EncodedString: localUser.coverPicture, options: .allZeros)
        self.localUserCoverPictureImageView.image = UIImage(data:coverImageData!)
        
        self.startSearchingForOpponent()
        
        matchmakingAnimatingView.startAnimatingDots()
    }
    
    override func viewWillAppear(animated: Bool) {
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
                NSLog("beste match %@", match as Match)
                NSLog("success");
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
    
    func pushToGame()
    {
        self.performSegueWithIdentifier("showGame", sender: nil)

    }
    
    func setupOpponentInterface()
    {
        let coverImageData = NSData(base64EncodedString: self.currentMatch!.opponentCoverPic, options: .allZeros)
        self.opponentCoverPictureImageView.image = UIImage(data:coverImageData!)
        self.opponentCoverPictureImageView.hidden = false
        
        NSLog("content %@", self.currentMatch!.content)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showGame"{
            var destinationViewController : LGGamingViewController = segue.destinationViewController as LGGamingViewController
            destinationViewController.match = self.currentMatch
            destinationViewController.hidesBottomBarWhenPushed = true;
        }
    }
    

}
