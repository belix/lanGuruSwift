//
//  LGRegistrationViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit
import AVFoundation


extension String  {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        var hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash)
    }
}

class LGRegistrationViewController: UIViewController, AVAudioPlayerDelegate{


    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var foreignLangPic: UIImageView!
    @IBOutlet weak var nativeLangPic: UIImageView!
    
    
    var loginClient : LGLoginClient = LGLoginClient()
    var indexForeign = 1
    var indexNative = 0
    let languageNames = ["DE", "EN", "FR", "ES", "IT"]
    var sound : Sound = Sound()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // TO-DO: wir müssen noch abfangen welche Sprachen initial gesetzt werden, um die indexForeign und indexNative
        // korrekt zu setzen
        

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
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")
    }
    
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }

    
    @IBAction func registerButtonPressed(sender: UIButton)
    {
        self.sound.readFileIntoAVPlayer("beep-holdtone", withType: "mp3")
        self.sound.playSoundWithVolume(10.0)
        
/*
        let userValid = (self.usernameTextField.text != "") ? true : false
        let passwordValid = (self.passwordTextField.text != "") ? true : false
        
        println(self.indexForeign)
        println(self.indexNative)
        
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
            
            var userDictionary : NSDictionary = ["user" : ["username" : self.usernameTextField.text, "email" : "", "password" : self.passwordTextField.text.md5, "nativelang" : self.languageNames[self.indexNative], "foreignlang" : self.languageNames[self.indexForeign], "devicetoken" : "", "fbid" : ""]]
            
            self.loginClient.registerUser(userDictionary) { (success) -> Void in
                if success{
                    
                    //var facebookClient : LGFacebookClient = LGFacebookClient()
                    //facebookClient.downloadProfilePicture()
                    
                    self.performSegueWithIdentifier("registrationFinished", sender: nil)
                    
                    NSLog("success")
                }
                else{
                    NSLog("fail")
                }
            }
        
        }
        */

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for txt in self.view.subviews {
            if txt.isKindOfClass(UITextField) && txt.isFirstResponder() {
                txt.resignFirstResponder()
            }
        }
    }

    @IBAction func beganTyping(sender: UITextField!) {
        if(sender.text != "") {
            if(sender.tag == 105) {
                usernameTextField.background = UIImage(named: "login-username.png")}
            else { passwordTextField.background = UIImage(named: "login-password.png") }
        }
        else {
            if(sender.tag == 105) {
                usernameTextField.background = UIImage(named: "login-username-error.png")}
            else { passwordTextField.background = UIImage(named: "login-password-error.png") }
        }
        
    }
    
    @IBAction func switchLanguagePressed(sender: AnyObject) {
        
        var langImage: [UIImage] = [
            UIImage(named: "flag_DE.png")!,
            UIImage(named: "flag_EN.png")!,
            UIImage(named: "flag_FR.png")!,
            UIImage(named: "flag_ES.png")!,
            UIImage(named: "flag_IT.png")!
        ]
        
        self.indexForeign = find(langImage, self.foreignLangPic.image!)!
        self.indexNative = find(langImage, self.nativeLangPic.image!)!
        
        
        if sender.tag == 100 {
            
            
            if(self.indexForeign == 0) {
                
                if((langImage.count-1) != self.indexNative) {
                    self.foreignLangPic.image = langImage[langImage.count-1]
                    self.indexForeign = langImage.count-1
                }
                else {
                    self.foreignLangPic.image = langImage[(langImage.count-2)]
                    self.indexForeign = langImage.count-2
                }
            }
                
            else {
                if (self.indexForeign-1) != self.indexNative {
                    self.foreignLangPic.image = langImage[self.indexForeign-1]
                    self.indexForeign = self.indexForeign-1
                }
                else {
                    if(self.indexForeign - 2 >= 0) {
                        self.foreignLangPic.image = langImage[self.indexForeign-2]
                        self.indexForeign = self.indexForeign-2
                    }
                    else {
                        self.foreignLangPic.image = langImage[langImage.count-1]
                        self.indexForeign = langImage.count-1
                        
                    }
                    
                }
            }
        }
            
        else if sender.tag == 101 {
            
            if(self.indexForeign == langImage.count-1) {
                if(self.indexNative == 0) {
                    self.foreignLangPic.image = langImage[1]
                    self.indexForeign = 1
                    
                }
                else {
                    self.foreignLangPic.image = langImage[0]
                    self.indexForeign = 0
                    
                }
            }
                
            else {
                if(self.indexForeign + 1 == self.indexNative) {
                    if(self.indexForeign + 2 <= (langImage.count-1)) {
                        self.foreignLangPic.image = langImage[self.indexForeign + 2]
                        self.indexForeign = self.indexForeign+2
                    }
                        
                    else {
                        self.foreignLangPic.image = langImage[0]
                        self.indexForeign = 0
                    }
                    
                }
                    
                else {
                    self.foreignLangPic.image = langImage[self.indexForeign + 1]
                    self.indexForeign = self.indexForeign+1
                }
            }
            
        }
            
            
        else if sender.tag == 102 {
            
            if(self.indexNative == 0) {
                
                if((langImage.count-1) != self.indexForeign) {
                    self.nativeLangPic.image = langImage[langImage.count-1]
                    self.indexNative = langImage.count-1
                }
                else {
                    self.nativeLangPic.image = langImage[(langImage.count-2)]
                    self.indexNative = langImage.count-2
                }
            }
                
            else {
                if (self.indexNative-1) != self.indexForeign {
                    self.nativeLangPic.image = langImage[self.indexNative-1]
                    self.indexNative = self.indexNative-1
                }
                else {
                    if(self.indexNative - 2 >= 0) {
                        self.nativeLangPic.image = langImage[self.indexNative-2]
                        self.indexNative = self.indexNative-2
                    }
                    else {
                        self.nativeLangPic.image = langImage[langImage.count-1]
                        self.indexNative = langImage.count-1
                        
                    }
                    
                }
            }
        }
            
        else {
            
            if(self.indexNative == langImage.count-1) {
                if(self.indexForeign == 0) {
                    self.nativeLangPic.image = langImage[1]
                    self.indexNative = 1
                    
                }
                else {
                    self.nativeLangPic.image = langImage[0]
                    self.indexNative = 0
                    
                }
            }
                
            else {
                if(self.indexNative + 1 == self.indexForeign) {
                    if(self.indexNative + 2 <= (langImage.count-1)) {
                        self.nativeLangPic.image = langImage[self.indexNative + 2]
                        self.indexNative = self.indexNative+2
                    }
                        
                    else {
                        self.nativeLangPic.image = langImage[0]
                        self.indexNative = 0
                    }
                    
                }
                    
                else {
                    self.nativeLangPic.image = langImage[self.indexNative + 1]
                    self.indexNative = 1
                }
            }
            
        }
    }
    // die validierung kann später verwendet werden, wenn nicht FB User in ihrem Profil eine Email angeben wollen
    // für eine Newsletter Registrierung zB oder ähnliches
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        if let result = NSPredicate(format: "SELF MATCHES %@", emailRegex) {
            return result.evaluateWithObject(candidate)
        }
        return false
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
