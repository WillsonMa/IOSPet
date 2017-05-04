//
//  Post.swift
//  IOSPet
//
//  Created by ZIQI MA on 5/3/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption: String!
    private var _imageUrl: String!
    private var _likesCount: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    
    var caption: String {
        return _caption
    }
    var imageUrl: String {
        return _imageUrl
    }
    var likesCount: Int {
        return _likesCount
    }
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likesCount = likesCount
    }
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"]  as? String{
            self._caption = caption
        }
        if let imageUrl = postData["imageUrl"]  as? String{
            self._imageUrl = imageUrl
        }
        if let likesCount = postData["likesCount"] as? Int {
            self._likesCount = likesCount
        }
        
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
    }
    func updateLikes(addLike: Bool) {
        if addLike {
            _likesCount = _likesCount + 1
        } else {
            _likesCount = _likesCount - 1
        }
        _postRef.child("likes").setValue(_likesCount)
    }

   
}
