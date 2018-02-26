//
//  FeedTableViewCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    var postView = PostView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        postView.postImage.setNeedsLayout()
        postView.commentLabel.setNeedsLayout()
    }
    
    func configCell(post: Post){
        configViewConstraints()
        postView.commentLabel.text = post.comment
        PostService.manager.getImagePost(urlImage: post.imageURL) { (imageOnline) in
            self.postView.postImage.image = imageOnline
        }
    }

    private func configViewConstraints() {
        contentView.addSubview(postView)
        postView.translatesAutoresizingMaskIntoConstraints = false
        postView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
