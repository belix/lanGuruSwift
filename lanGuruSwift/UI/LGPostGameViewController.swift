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
    
    var match : Match?

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup statusbar
        var profilePictureImageData = NSData(base64EncodedString: match!.opponentProfilePic, options: .allZeros)
        self.opponentProfilePictureImageView.image = UIImage(data:profilePictureImageData!)
        self.opponentProfilePictureImageView.layer.cornerRadius = self.opponentProfilePictureImageView.frame.size.height/2
        self.opponentProfilePictureImageView.clipsToBounds = true
        
        profilePictureImageData = NSData(base64EncodedString: User.getLocalUser().profilePicture, options: .allZeros)
        self.localUserProfilePictureView.image = UIImage(data:profilePictureImageData!)
        self.localUserProfilePictureView.layer.cornerRadius = self.localUserProfilePictureView.frame.size.height/2
        self.localUserProfilePictureView.clipsToBounds = true
    
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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