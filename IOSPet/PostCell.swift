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
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var likesref: FIRDatabaseReference!
//        DataService.ds.REF_USERS_CURRENT.child("likes")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
        
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        
        likesref = DataService.ds.REF_USERS_CURRENT.child("likes").child(post.postKey)
        
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
        
        likesref.observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
        
    }
    func likeTapped(sender: UITapGestureRecognizer) {
        likesref.observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.updateLikes(addLike: true)
                self.likesref.setValue(true)
            } else {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.updateLikes(addLike: false)
                self.likesref.removeValue()
            }
        })
    }
   
}
