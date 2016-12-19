//
//  ShotsTableViewCell.swift
//  DribbleTest
//
//  Created by Admip on 14.11.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class ShotsTableViewCell: UITableViewCell {

    
    
    @IBOutlet var ImageShotAvtor: UIImageView!
    
    @IBOutlet var ImageShotLike: UIImageView!
    
    
    
    
    @IBOutlet var ImageShot: UIImageView!
    
    @IBOutlet var TitleShot: UILabel!
    @IBOutlet var DescriptionShot: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   

}
