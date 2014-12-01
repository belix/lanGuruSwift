//
//  LGProfileViewController.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let localUser : User = User.getLocalUser()
        self.coverImageView.image = localUser.getCoverPictureImage()
        
        addEffect()
        
        self.profilePictureImageView.image = localUser.getProfilePictureImage()
        self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.height/2
        self.profilePictureImageView.clipsToBounds = true
        
        self.usernameLabel.text = localUser.username
        self.userPointsLabel.text = "\(String(Int(localUser.ranking))) Pts"
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func addEffect() {
        var effect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        
        var effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = CGRectMake(0, 0, 600, 265)
        
        self.coverImageView.addSubview(effectView)
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
