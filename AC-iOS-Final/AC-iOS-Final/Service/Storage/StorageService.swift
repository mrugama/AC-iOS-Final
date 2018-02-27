//
//  StorageService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseStorage

@objc protocol StorageServiceDelegate: class {
    @objc optional func didImageSave()
    @objc optional func didFailImageSave(error: Error)
    @objc optional func uploadImageProgress(progress: Float)
}

class StorageService {
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        imagesRef = storageRef.child("images")
    }
    static let manager = StorageService()
    
    weak var delegate: StorageServiceDelegate?
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var imagesRef: StorageReference!
    
    public func getStorageRef() -> StorageReference { return storageRef }
    public func getImagesRef() -> StorageReference { return imagesRef }
}
