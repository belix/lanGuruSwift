//
//  LGRootViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGRootViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var facebookLoginView: FBLoginView!

    var loginClient : LGLoginClient

    required init(coder aDecoder: NSCoder) {
        self.loginClient = LGLoginClient()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.facebookLoginView.readPermissions = ["public_profile", "email", "user_friends"];
        self.facebookLoginView.delegate = self;
        
        if NSUserDefaults.standardUserDefaults().objectForKey("localUserID") != nil
        {
            performSegueWithIdentifier("loginFinished", sender: nil)
        }
        
        self.navigationController?.navigationBar.hidden = true
        self.loginClient = LGLoginClient()

    }
    

    @IBAction func textFieldsEditingChanged(sender: UITextField!) {
        if(sender.text != "") {
            if(sender.tag == 107) {
                usernameTextField.background = UIImage(named: "login-username.png")}
            else {
                passwordTextField.background = UIImage(named: "login-password.png")
            }
        }
        else {
            if(sender.tag == 107) {
                usernameTextField.background = UIImage(named: "login-username-error.png")
            }
            else {
                passwordTextField.background = UIImage(named: "login-password-error.png")
            }
        }
        
    }
    @IBAction func loginUserPressed(sender: AnyObject) {
        
        let userValid = (self.usernameTextField.text != "") ? true : false
        let passwordValid = (self.passwordTextField.text != "") ? true : false
        
        usernameTextField.background = UIImage(named: "login-username.png")
        passwordTextField.background = UIImage(named: "login-password.png")
        
        if(!userValid || !passwordValid) {
            if(!userValid) {
                usernameTextField.background = UIImage(named: "login-username-error.png")
            }
            
            if(!passwordValid) {
                passwordTextField.background = UIImage(named: "login-password-error.png")
            }
        }
            
        else {

            var userDictionary : NSDictionary = ["user" : ["username" : self.usernameTextField.text, "password" : self.passwordTextField.text.md5]]

            self.loginClient.loginForUser(userDictionary, isFacebookLogin: false) { (success) -> Void in
                if success{
                    
                    self.performSegueWithIdentifier("loginFinished", sender: nil)
                    
                    NSLog("success")
                }
                else{
                    NSLog("fail")
                }
            }
            
        }

        
    }
    
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView)
    {
        NSLog("logged in")
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView?, user: FBGraphUser)
    {
        NSLog("graph User %@", user.last_name)
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
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView?)
    {
        NSLog("logged out")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for txt in self.view.subviews {
            if txt.isKindOfClass(UITextField) && txt.isFirstResponder() {
                txt.resignFirstResponder()
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
