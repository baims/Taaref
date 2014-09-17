//
//  CategoryTableViewCell.swift
//  Taaref
//
//  Created by Bader Alrasheed on 9/16/14.
//  Copyright (c) 2014 Baims. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    var categoryID : String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
