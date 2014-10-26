//
//  LGFriendTableViewCell.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 26.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let localUser : User = User.getLocalUser()
        
        let profilePictureImageData = NSData(base64EncodedString: localUser.profilePicture, options: .allZeros)
        self.profileImageView.image = UIImage(data: profilePictureImageData!)
        self.profileImageView.layer.cornerRadius = 30
        self.profileImageView.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
