//
//  UploadVC+Delegations.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/28/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

// MARK:- ImagePickerController Delegate
extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            uploadView.uploadImageView.image = pickedImage
            uploadView.uploadButton.isHidden = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

extension UploadVC: StorageServiceDelegate {
    func uploadImageProgress(progress: Float) {
        uploadView.progressBar.isHidden = false
        uploadView.progressBar.progress = progress
    }
    func didImageSave() {
        uploadView.progressBar.isHidden = true
        self.customMessage(title: "Image Saved", message: "Image saved succeed")
        uploadView.resetView()
    }
    func didFailImageSave(error: Error) {
        self.customMessage(title: "Image failed", message: error.localizedDescription)
    }
}

extension UploadVC: UploadDelegate {
    func didUploadButtonPressed() {
        openMenuPhotos()
    }
}
