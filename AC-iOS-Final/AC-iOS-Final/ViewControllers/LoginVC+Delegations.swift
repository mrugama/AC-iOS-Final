//
//  LoginVC+Delegations.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth

extension LoginVC: LoginDelegate {
    func didSignUpButtonPressed(_ userName: String, _ email: String, _ password: String) {
        self.authUserService.createUser(userName: userName, email: email, password: password)
    }
    
    func didSignInButtonPressed(_ email: String, _ password: String) {
        self.authUserService.signIn(email: email, password: password)
    }
}

extension LoginVC: AuthUserServiceDelegate {
    func didSignIn(_ userService: AuthUserService, user: User) {
        let tabBar = TabBarController()
        present(tabBar, animated: true, completion: nil)
    }
    
    func didSignOut(_ userService: AuthUserService) {
        let loginVC = LoginVC()
        self.dismiss(animated: true, completion: nil)
        present(loginVC, animated: true, completion: nil)
    }
    
    func didCreateUser(_ userService: AuthUserService, user: User) {
        guard let userName = user.displayName else {return}
        guard let email = user.email else {return}
        customErrorMessage(title: "Welcome \(userName)", message: "the user was created with \(email), please verify your email.")
    }
    
    func didFailToSignIn(_ userService: AuthUserService, error: Error) {
        customErrorMessage(title: "SignIn failed", message: error.localizedDescription)
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        customErrorMessage(title: "Create user failed", message: error.localizedDescription)
    }
    
    func didFailToEmailVerify(_ userService: AuthUserService, user: User, error: Error?) {
        if let error = error {
            customErrorMessage(title: "Email veryfication failed", message: error.localizedDescription)
        } else {
            customErrorMessage(title: "Email veryfication failed", message: "Unknown error")
        }
    }
}
