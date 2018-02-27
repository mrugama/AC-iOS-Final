//
//  TabBarVC.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth

class FeedVC: UIViewController {

    var feedView = FeedView()
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.feedTableView.reloadData()
            }
        }
    }
    
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        configFeedView()
        feedView.feedTableView.delegate = self
        feedView.feedTableView.dataSource = self
        loadData()
    }
    
    private func loadData() {
        PostService.manager.getPosts { (posts) in
            self.posts = []
            self.posts = posts
        }
    }

    private func configNav() {
        view.backgroundColor = .white
        navigationItem.title = "Unit6Final-staGram"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SignOut", style: .done, target: self, action: #selector(signOutButtonPressed))
    }
    
    private func configFeedView() {
        view.addSubview(feedView)
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    @objc private func signOutButtonPressed() {
        
        do {
            try Auth.auth().signOut()
            let loginVC = LoginVC()
            self.present(loginVC, animated: true, completion: nil)
        }
        catch {
            customMessage(title: "LogOut failed", message: error.localizedDescription)
        }
    }
    
    func customMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FeedVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //UITableViewAutomaticDimension
        return UITableViewAutomaticDimension
    }
}

extension FeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? FeedTableViewCell {
            cell.configCell(post: post)
            cell.setNeedsLayout()
            return cell
        }
        
        return UITableViewCell()
    }
}
