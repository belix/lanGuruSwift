//
//  VocabularyTableViewCell.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 20.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import UIKit

class LGVocabularyTableViewCell: UITableViewCell {

    @IBOutlet weak var nativeLanguageLabel: UILabel!
    @IBOutlet weak var foreignLanguageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
