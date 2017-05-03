//
//  PostCell.swift
//  IOSPet
//
//  Created by ZIQI MA on 5/2/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usrname: UILabel!
    @IBOutlet weak var psotImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesCount: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesCount.text = "\(post.likesCount)"
    }

}
