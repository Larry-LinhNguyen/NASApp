//
//  CollisionTableViewCell.swift
//  NASApp
//
//  Created by Andrea Miotto on 26/03/17.
//  Copyright © 2017 Andrea Miotto. All rights reserved.
//

import UIKit

class CollisionTableViewCell: UITableViewCell {
    
    //----------------------
    // MARK: - Outlets
    //----------------------

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hazardousLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //----------------------
    // MARK: - View Methods
    //----------------------
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
