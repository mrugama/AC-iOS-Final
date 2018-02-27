//
//  PostView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PostView: UIView {
    
    lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "No Comment"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        commentLabel.setNeedsLayout()
    }
    
    private func setupInit() {
        addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 8).isActive = true
        postImage.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        postImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        postImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8).isActive = true
        commentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        commentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
}
