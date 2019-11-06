//
//  BlogTableViewCell.swift
//  yinkinChat
//
//  Created by ying kit ng on 10/1/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {
    //@IBOutlet weak var someView: UIView!
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
