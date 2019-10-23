//
//  PhotoCell.swift
//  TestCode
//
//  Created by Guest1 on 12/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var serachedImage: UIImageView!
    @IBOutlet weak var imageCompleteNameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
