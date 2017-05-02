//
//  RoundView.swift
//  IOSPet
//
//  Created by ZIQI MA on 5/1/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import UIKit

class RoundView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_SHADE, green: SHADOW_SHADE, blue: SHADOW_SHADE, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2.2
    }


}
