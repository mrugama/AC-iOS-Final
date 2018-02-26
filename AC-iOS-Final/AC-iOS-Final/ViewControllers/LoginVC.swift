//
//  LoginVC.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    var loginLogoView = LoginLogoView()
    var authUserService = AuthUserService()

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configLoginViews()
        authUserService.delegate = self
        loginLogoView.delegate = self
    }
    
    private func configViewController() {
        view.backgroundColor = .white
    }

    private func configLoginViews() {
        view.addSubview(loginLogoView)
        loginLogoView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func customErrorMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
