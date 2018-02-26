//
//  Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Post {
    let ref: DatabaseReference
    let postId: String
    let comment: String
    let userId: String
    let imageURL: String
    
    init(ref: DatabaseReference, comment: String, userId: String) {
        self.ref = ref
        self.postId = ref.key
        self.comment = comment
        self.userId = userId
        self.imageURL = ""
    }
    
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.postId = snapShot.ref.key
        self.comment = value?["comment"] as? String ?? ""
        self.userId = value?["userId"] as? String ?? ""
        self.imageURL = value?["imageURL"] as? String ?? ""
    }
    
    func toObjAny() -> [String: Any] {
        return ["postId": postId, "comment": comment, "userId": userId, "imageURL": imageURL]
    }
}
