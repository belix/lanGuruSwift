//
//  LGRegistrationViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGRegistrationViewController: UIViewController{


    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var loginClient : LGLoginClient = LGLoginClient()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    func loginViewShowingLoggedInUser(loginView: FBLoginView)
    {
        NSLog("logged in")
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView?, user: FBGraphUser)
    {
        NSLog("graph User %@", user.last_name)
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView?)
    {
        NSLog("logged out")
    }
    
    @IBAction func registerButtonPressed(sender: UIButton)
    {
        var userDictionary : NSDictionary = ["user" : ["username" : self.usernameTextField.text, "email" : self.emailTextField.text, "password" : self.passwordTextField.text, "nativelang" : "", "foreignlang" : "", "devicetoken" : ""]]
        
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
