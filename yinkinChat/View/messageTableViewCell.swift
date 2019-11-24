//
//  messageTableViewCell.swift
//  yinkinChat
//
//  Created by ying kit ng on 8/20/19.
//  Copyright © 2019 ying kit ng. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUsername: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
