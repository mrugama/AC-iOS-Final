//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

@objc protocol UploadDelegate: class {
    @objc optional func didUploadButtonPressed()
}

class UploadView: UIView {

    weak var delegate: UploadDelegate?
    
    lazy var uploadImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.lightGray
        return image
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var commentTextView: UITextView = {
        let text = UITextView()
        text.text = " Add a description..."
        text.textColor = UIColor.lightGray
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 2
        text.font = UIFont.systemFont(ofSize: 18)
        text.autocorrectionType = .no
        return text
    }()
    
    lazy var progressBar: UIProgressView = {
        let pb = UIProgressView()
        pb.progress = 0.0
        return pb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
        resetView()
        progressBar.isHidden = true
        commentTextView.delegate = self
        uploadButton.addTarget(self, action: #selector(isUploadButtonPressed), for: .touchUpInside)
    }
    
    @objc private func isUploadButtonPressed() {
        delegate?.didUploadButtonPressed?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func resetView() {
        uploadImageView.image = nil
        uploadButton.isHidden = false
        uploadButton.setImage(UIImage.init(named: "camera_icon"), for: .normal)
        commentTextView.text = " Add a description..."
    }
    
    private func setupInit() {
        addSubview(uploadImageView)
        uploadImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(snp.width)
            make.top.equalTo(snp.top)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(progressBar)
        progressBar.snp.makeConstraints { (make) in
            make.centerX.equalTo(uploadImageView.snp.centerX)
            make.centerY.equalTo(uploadImageView.snp.centerY)
            make.width.equalTo(uploadImageView.snp.width).multipliedBy(0.5)
        }
        
        addSubview(uploadButton)
        uploadButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(64)
            make.centerY.equalTo(uploadImageView.snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(uploadImageView.snp.bottom).offset(16)
            make.centerX.equalTo(snp.centerX)
            make.left.equalTo(snp.left).offset(8)
            make.right.equalTo(snp.right).offset(-8)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }
}

extension UploadView: UITextViewDelegate {
    //gets rid of the fake placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    //puts back fake placeholder if the textview.text is empty
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add a Description.."
            textView.textColor = UIColor.lightGray
        }
        textView.resignFirstResponder()
    }
}


