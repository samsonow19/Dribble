//
//  IcarouselView.swift
//  DribbleTest
//
//  Created by Admip on 20.12.16.
//  Copyright © 2016 Admip. All rights reserved.
//

import UIKit

class IcarouselView: UIView {
    
    @IBOutlet var nameUser: UILabel!

    @IBOutlet var imageUser: UIImageView!
    
    @IBOutlet var titleShot: UILabel!
   
    @IBOutlet var date: UILabel!
    
    var view: UIView!
    var nibName: String = "IcarouselView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func loadFromNib() -> UIView {
        let bundel = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundel)
        let view  = nib.instantiateWithOwner(self, options: nil)[0] as! UIView

        return view
    }
    
    func setup() {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        addSubview(view)
    }
}
