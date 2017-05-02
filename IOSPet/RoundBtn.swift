//
//  RoundBtn.swift
//  IOSPet
//
//  Created by ZIQI MA on 4/24/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        layer.shadowColor = UIColor(red: SHADOW_SHADE, green: SHADOW_SHADE, blue: SHADOW_SHADE, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
        imageView?.contentMode = .scaleAspectFit
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 3
    }

}
