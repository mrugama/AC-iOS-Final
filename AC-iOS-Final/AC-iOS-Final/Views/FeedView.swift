//
//  FeedView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FeedView: UIView {

    lazy var feedTableView: UITableView = {
        let table = UITableView()
        //table.autoresizesSubviews = true
//        table.estimatedRowHeight = self.bounds.width * 1.2
//        table.rowHeight = UITableViewAutomaticDimension
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: "PostCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInit() {
        addSubview(feedTableView)
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        feedTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        feedTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
