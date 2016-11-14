//
//  CommentsTableViewCell.swift
//  DribbleTest
//
//  Created by Admip on 14.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet var CommentImage: UIImageView!
    @IBOutlet var CommentLabel: UILabel!
    @IBOutlet var NameAvtorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
