//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class UploadView: UIView {

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
    
    lazy var commentTextField: UITextView = {
        let text = UITextView()
        text.text = " Add a description..."
        text.textColor = UIColor.lightGray
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 2
        text.font = UIFont.systemFont(ofSize: 18)
        text.autocorrectionType = .no
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
        resetView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func resetView() {
        uploadImageView.image = nil
        uploadButton.isHidden = false
        uploadButton.setImage(UIImage.init(named: "camera_icon"), for: .normal)
        commentTextField.text = " Add a description..."
    }
    
    private func setupInit() {
        addSubview(uploadImageView)
        uploadImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(snp.width)
            make.top.equalTo(snp.top)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(uploadButton)
        uploadButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(64)
            make.centerY.equalTo(uploadImageView.snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(commentTextField)
        commentTextField.snp.makeConstraints { (make) in
            make.top.equalTo(uploadImageView.snp.bottom).offset(16)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }

}
