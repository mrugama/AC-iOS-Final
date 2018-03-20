//
//  GoogleImageTableViewCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 3/1/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class GoogleImageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    lazy var googleImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    func configCell(image: UIImage) {
        setupView()
    }
    
    private func setupView() {
        addSubview(googleImageView)
        googleImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
    }
}
