//
//  PopoutView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 3/1/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

@objc protocol PopoutViewDelegate {
    @objc optional func didSearchImageButtonPressed()
}

class PopoutView: UIView {
    
    weak var delegate: PopoutViewDelegate?

    lazy var fromCamaraButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoCamara_64x64"), for: .normal)
        return button
    }()
    
    lazy var fromGalleryButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoGallery_64x64"), for: .normal)
        return button
    }()
    
    lazy var fromOnlineButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoOnline_64x64"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fromOnlineButton.addTarget(self, action: #selector(fromOnlineButtonPressed), for: .touchUpInside)
    }
    
    @objc private func fromOnlineButtonPressed() {
        delegate?.didSearchImageButtonPressed!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(fromGalleryButton)
        fromGalleryButton.snp.makeConstraints { (make) in
            make.center.equalTo(snp.center)
            make.height.width.equalTo(64)
        }
        
        addSubview(fromCamaraButton)
        fromCamaraButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(fromGalleryButton.snp.top).offset(-32)
            make.height.width.equalTo(64)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(fromOnlineButton)
        fromOnlineButton.snp.makeConstraints { (make) in
            make.top.equalTo(fromGalleryButton.snp.bottom).offset(32)
            make.height.width.equalTo(64)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
