//
//  PostVC.swift
//  IOSPet
//
//  Created by ZIQI MA on 5/2/17.
//  Copyright © 2017 ZIQI MA. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class PostVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var imageUpload: UIImageView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    //Gloable variable
    static var imgCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.captionField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with:  {(snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            for snap in snapshot {
                print("snap: \(snap)")
                if let postDict = snap.value as? Dictionary<String, AnyObject> {
                    let key = snap.key
                    let post = Post(postKey: key, postData: postDict)
                    self.posts.append(post)
                    
                }
            }
          }
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let post = posts[indexPath.row]
//        print("post\(post.caption)")
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier:"PostCell") as? PostCell {
            if let img = PostVC.imgCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return PostCell()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageUpload.image = image
        } else {
            print("No valid image")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadImage(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func postNew(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("Will: Caption need to be entered")
            return
        }
        guard let img = imageUpload.image else {
            print("Will: Image need to be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let mtdata = FIRStorageMetadata()
            mtdata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMG.child(imgUid).put(imgData, metadata: mtdata) { (mtdata, error) in
                if error != nil {
                    print("Will: Failed to upload image to fir storage")
                } else {
                    print("Will: Succesfully uploaded image to fir storage")
                    let downloadURL = mtdata?.downloadURL()?.absoluteString
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
