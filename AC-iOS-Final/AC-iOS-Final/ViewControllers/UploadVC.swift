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
    var popoutView = PopoutView()
    var searchOnline = SearchImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupUploadView()
        uploadView.delegate = self
        StorageService.manager.delegate = self
        popoutView.delegate = self
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
        
        view.addSubview(popoutView)
        popoutView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.right)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(70)
        }
        
        view.addSubview(searchOnline)
        searchOnline.snp.makeConstraints { (make) in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.60)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
        }
        searchOnline.backgroundColor = .white
        searchOnline.layer.opacity = 0.4
        searchOnline.isHidden = true
    }
    
    @objc private func saveImageSelected() {
        guard let comment = uploadView.commentTextView.text else {
            customMessage(title: "No comment", message: "Please comment the photo before you submit.")
            return
        }
        guard let image = uploadView.uploadImageView.image else {
            customMessage(title: "No photo", message: "Please pick up a photo from Library or Camara before you submit.")
            return
        }
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
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseIn, .allowUserInteraction], animations: {
            self.popoutView.center = CGPoint(x: (self.view.center.x * 2) - 50, y: self.view.center.y)
        }, completion: nil)
        self.present(addImageActionSheet, animated: true, completion: nil)
    }
}

extension UploadVC: PopoutViewDelegate {
    func didSearchImageButtonPressed() {
        searchOnline.isHidden = false
    }
}


