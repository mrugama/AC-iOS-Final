//
//  UploadVC.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class UploadVC: UIViewController {

    var uploadView = UploadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupUploadView()
        uploadView.uploadButton.addTarget(self, action: #selector(openMenuPhotos), for: .touchUpInside)
        StorageService.manager.delegate = self
    }

    private func configNav() {
        view.backgroundColor = .white
        navigationItem.title = "Unit6Final-staGram"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveImageSelected))
    }
    
    private func setupUploadView() {
        view.addSubview(uploadView)
        uploadView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    @objc private func saveImageSelected() {
        guard let comment = uploadView.commentTextView.text else {print("No comment"); return}
        guard let image = uploadView.uploadImageView.image else {print("No image");return}
        PostService.manager.saveNewPost(content: comment, image: image)
    }
    
    func customMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func openMenuPhotos() {
        let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openCamera = UIAlertAction.init(title: "Take a photo", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        let openGallery = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        addImageActionSheet.addAction(openCamera)
        addImageActionSheet.addAction(openGallery)
        addImageActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
        self.present(addImageActionSheet, animated: true, completion: nil)
    }
}

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
}
