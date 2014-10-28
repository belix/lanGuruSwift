//
//  LGChallengeViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 26.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var friendListTableView: UITableView!
    var model = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "User")
        
        model = LGCoreDataManager.sharedInstance().managedObjectStore.mainQueueManagedObjectContext.executeFetchRequest(fReq, error:&error)!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: LGFriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as LGFriendTableViewCell
        
        var user : User = model[indexPath.row] as User
        
        let profilePictureImageData = NSData(base64EncodedString: user.profilePicture, options: .allZeros)
        cell.profileImageView.image = UIImage(data: profilePictureImageData!)
        cell.usernameLabel.text = user.username
        cell.userRankingLabel.text = "\(user.ranking)"
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMatchmaking"{
            var destinationViewController : LGMatchmakingViewController = segue.destinationViewController as LGMatchmakingViewController
            destinationViewController.hidesBottomBarWhenPushed = true;
        }
        
    }

}