//
//  PostTableViewCell.swift
//  c1-test
//
//  Created by Fernando Rocha Silva on 5/3/16.
//  Copyright © 2016 Fernando Rocha Silva. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
