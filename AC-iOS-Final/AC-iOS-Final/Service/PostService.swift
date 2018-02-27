//
//  PostService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

@objc protocol PostServiceDelegate: class {
    @objc optional func didSavePost()
    @objc optional func didFailSavePost(error: Error)
    @objc optional func didSaveImage()
    @objc optional func didFailSaveImage(error: Error)
}

class PostService {
    private init() {
        dbRef = Database.database().reference()
        postRef = dbRef.child("posts")
        guard let cUser = Auth.auth().currentUser else {print("No current user available"); return}
        currentUser = cUser
    }
    
    weak var delegate: PostServiceDelegate?
    static let manager = PostService()
    private var dbRef: DatabaseReference!
    private var postRef: DatabaseReference!
    private var currentUser: User!
    
    public func getDB()-> DatabaseReference { return dbRef }
    public func getPostsRef() -> DatabaseReference {return postRef}
    
    public func getPosts(completionHandler: @escaping ([Post]) -> Void) {
        postRef.observe(.value) { (snapShot) in
            var posts = [Post]()
            for post in snapShot.children {
                let newPost = Post(snapShot: post as! DataSnapshot)
                posts.insert(newPost, at: 0)
            }
            completionHandler(posts)
        }
    }
    
    public func saveNewPost(content: String, image: UIImage) {
        let newPost = postRef.childByAutoId()
        let post = Post(ref: newPost, comment: content, userId: currentUser.uid)
        newPost.setValue(post.toObjAny()){ (error, dbRef) in
            if let error = error {
                self.delegate?.didFailSavePost!(error: error)
                return
            } else {
                StorageService.manager.storeImage(image: image, postId: newPost.key, userId: nil, isUpdatingUserImage: false)
                self.delegate?.didSavePost!()
            }
        }
    }
    
    public func getImagePost(urlImage: String, completion: @escaping (UIImage) -> Void) {
        let image = UIImageView()
        if let imageURL = URL(string: urlImage) {
            DispatchQueue.main.async {
                image.kf.setImage(with: imageURL, placeholder: UIImage.init(named: "camera_icon"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                    if let error = error {
                        print(error)
                    }
                    if let image = image {
                        completion(image)
                    }
                }
            }
        }
    }
}
