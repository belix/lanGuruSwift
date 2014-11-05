//
//  LGFriendTableViewCell.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 26.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

enum CellType
{
    case standard
    case matchRequestOpen
    case matchRequestFinished
}

class LGFriendTableViewCell: UITableViewCell {

    var cellType : CellType = CellType.standard
    var currentMatch : Match?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    
    @IBOutlet weak var userRankingLabel: UILabel!
    
    @IBOutlet weak var matchRequestImageView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.profileImageView.layer.cornerRadius = 30
        self.profileImageView.clipsToBounds = true
        
    }
}
