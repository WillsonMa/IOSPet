//
//  Textfield.swift
//  IOSPet
//
//  Created by ZIQI MA on 4/28/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import UIKit

class Textfield: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
