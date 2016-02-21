//
//  SentMemeTableCell.swift
//  MemeMe
//
//  Created by Gareth Hunt on 21/02/2016.
//  Copyright © 2016 ghunt03. All rights reserved.
//

import UIKit

class SentMemeTableCell: UITableViewCell {

    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var previewText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
