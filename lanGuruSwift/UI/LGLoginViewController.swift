//
//  LGLoginViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 22.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGLoginViewController: UIViewController,FBLoginViewDelegate{

    @IBOutlet weak var profilePictureView: FBProfilePictureView!
    @IBOutlet weak var facebookLoginView: FBLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.facebookLoginView.readPermissions = ["public_profile", "email", "user_friends"];
        self.facebookLoginView.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loginViewShowingLoggedInUser(loginView: FBLoginView) {
    
        NSLog("logged in")
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView?, user: FBGraphUser){
        
        NSLog("graph User %@", user.last_name)
        self.profilePictureView.profileID =  user.objectID;
        var userDictionary : NSDictionary = ["fbid" : user.objectID]
        var loginClient : LGLoginClient = LGLoginClient()
        loginClient.loginForUser(userDictionary, isFacebookLogin: true) { (success) -> Void in
            if success{
                
                var facebookClient : LGFacebookClient = LGFacebookClient()
                facebookClient.downloadProfilePicture()
                facebookClient.loadFriendsDetails()
                NSLog("success")
                
                self.performSegueWithIdentifier("loginFinished", sender: nil)
            }
            else{
                NSLog("fail")
            }
        }
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView?) {
        
        NSLog("logged out")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
