//
//  LGRegistrationViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGRegistrationViewController: UIViewController, FBLoginViewDelegate{

    @IBOutlet weak var profilePictureView: FBProfilePictureView!
    @IBOutlet weak var facebookLoginView: FBLoginView!

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var facebookID : String?
    var loginClient : LGLoginClient = LGLoginClient()
    
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
        self.profilePictureView.profileID =  user.objectID
        self.facebookID = user.objectID
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView?) {
        
        NSLog("logged out")
    }
    
    @IBAction func registerButtonPressed(sender: UIButton)
    {
        var userDictionary : NSDictionary = ["user" : ["username" : self.usernameTextField.text, "password" : self.passwordTextField.text, "nativelang" : "", "foreignlang" : "", "email" : "", "fbid" : self.facebookID, "devicetoken" : ""]]
        
        self.loginClient.registerUser(userDictionary) { (success) -> Void in
            if success{
                
                var facebookClient : LGFacebookClient = LGFacebookClient()
                facebookClient.downloadProfilePicture()
                
                self.performSegueWithIdentifier("registrationFinished", sender: nil)
                
                NSLog("success")
            }
            else{
                NSLog("fail")
            }
        }
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
