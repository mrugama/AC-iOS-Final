//
//  SearchImageView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 3/1/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SearchImageView: UIView {
    
    var images = [OnlineImage]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.images.count)
            }
        }
    }

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search online"
        return sb
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(GoogleImageTableViewCell.self, forCellReuseIdentifier: "GoogleCell")
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.bottom.equalTo(snp.bottom)
        }
    }
}

extension SearchImageView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            ImageSearcher.manager.searchForTerm(term: text, page: 0, completion: { (googleImages, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let images = googleImages {
                    self.images = images
                }
            })
        }
    }
    
}

extension SearchImageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SearchImageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = images[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleCell", for: indexPath) as? GoogleImageTableViewCell {
            cell.configCell(image: image.thumbnail!)
            return cell
        }
        return UITableViewCell()
    }
}
