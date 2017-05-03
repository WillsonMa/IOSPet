//
//  PostCell.swift
//  IOSPet
//
//  Created by ZIQI MA on 5/2/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usrname: UILabel!
    @IBOutlet weak var postImg: UIImageView!
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
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesCount.text = "\(post.likesCount)"
        
        if img != nil {
            self.postImg.image = img
        } else {
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
                    if error != nil {
                        print("Failed to download picture from FIR Storage")
                    } else {
                        print("image downloaded from image Storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.postImg.image = img
                                PostVC.imgCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                })
            }
    }

}
