//
//  LGChallengeViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 26.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LGMatchRequestPopoverDelegate{

    @IBOutlet weak var friendListTableView: UITableView!
    var model = []
    
    let matchMakingClient : LGMatchmakingClient = LGMatchmakingClient.self()
    let activeMatchesClient : LGActiveMatchesClient = LGActiveMatchesClient.self()
    let userCient : LGUserClient = LGUserClient.self()
    
    let localUser : User = User.getLocalUser()
    
    var activeMatches : [Match]? = []
    
    var searchingForFriend : Bool = false
    var isAccepter : Bool = false
    var searchingFriendMatchID : NSInteger = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        model = LGCoreDataManager.sharedInstance().managedObjectStore.mainQueueManagedObjectContext.executeFetchRequest(fReq, error:&error)!
        
        self.activeMatchesClient.getActiveMatchesForUserID(localUser.userID){ (activeMatches) -> Void in
            if activeMatches != nil
            {
                self.activeMatches = activeMatches as? Array
                self.friendListTableView .reloadData()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.searchingForFriend = false
        self.isAccepter = false
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        //check for existing match requests
        self.activeMatches = []
        self.activeMatchesClient.getActiveMatchesForUserID(localUser.userID){ (activeMatches) -> Void in
            if activeMatches != nil
            {
                self.activeMatches = activeMatches as? Array
            }
            self.friendListTableView .reloadData()
        }
        
        //refrehst friend details
        self.userCient.updateFriendsDetailsWithCompletion(){(success) -> Void in
            if success
            {
                self.friendListTableView .reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: LGFriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as LGFriendTableViewCell
        
        var user : User = model[indexPath.row] as User
        
        let profilePictureImageData = NSData(base64EncodedString: user.profilePicture, options: .allZeros)
        cell.profileImageView.image = UIImage(data: profilePictureImageData!)
        cell.usernameLabel.text = user.username
        cell.userRankingLabel.text = "\(user.ranking)"
        cell.matchRequestImageView.hidden = true
        
        //for active match requests
        for match in self.activeMatches!
        {
            if (match.opponent1 == user.username && match.opponent1 != localUser.username) && (match.status == 0 || match.status == 2)
            {
                cell.matchRequestID = match.identity
                cell.matchRequestImageView.hidden = false
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let cell : LGFriendTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as LGFriendTableViewCell
        
        //accept match request
        if !cell.matchRequestImageView.hidden
        {
            let popover : LGMatchRequestPopoverView = NSBundle.mainBundle().loadNibNamed("LGMatchRequestPopoverView", owner: self, options: nil)[0] as LGMatchRequestPopoverView
            popover.frame = CGRectMake(self.view.frame.size.width/2 - popover.frame.size.width/2, self.view.frame.size.height/2 - popover.frame.size.height/2, popover.frame.size.width, popover.frame.size.height)
            popover.delegate = self
            popover.descriptionLabel.text = String(format:"%@ will die zu einem Duell herausfordern. Hast du Bock?" ,cell.usernameLabel.text!)
            popover.matchRequestID = cell.matchRequestID
            popover.layoutIfNeeded()
            self.view.addSubview(popover)
            
        }//create match request
        else
        {
            var friend : User = model[indexPath.row] as User
            
            var alert = UIAlertController(title: "Challenge", message: String(format: "Willst du %@ zu einem Match herausfordern", friend.username), preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title:"Jap", style: UIAlertActionStyle.Default, handler: { alertAction in
                self.matchMakingClient.checkForFriendChallenge(friend,fromUser:self.localUser){
                    (matchID) -> Void in
                    
                    if(matchID != 0)
                    {
                        self.searchingForFriend = true
                        self.searchingFriendMatchID = matchID
                        self.performSegueWithIdentifier("showMatchmaking", sender: nil)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title:"Nope", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        

    }
    
    func enterGame(matchID : Int)
    {
        self.searchingForFriend = true
        self.isAccepter = true
        self.searchingFriendMatchID = matchID
        self.performSegueWithIdentifier("showMatchmaking", sender: nil)
    }
    
    
    @IBAction func playVsComputerButtonPressed(sender: AnyObject)
    {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if segue.identifier == "showMatchmaking"{
            var destinationViewController : LGMatchmakingViewController = segue.destinationViewController as LGMatchmakingViewController
            
            if self.searchingForFriend
            {
                destinationViewController.searchingForFriend = true
                destinationViewController.searchingFriendMatchID = self.searchingFriendMatchID
                destinationViewController.isAccepter = self.isAccepter
            }
            
            destinationViewController.hidesBottomBarWhenPushed = true;
        }
    }
}
