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
    
    var authUserService = AuthUserService()

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        addSubviews()
        configureConstraints()
        addObservers()
        authUserService.delegate = self
        loginLogoView.delegate = self
    }
    
    lazy var loginLogoView: LoginLogoView = {
        let view = LoginLogoView()
        return view
    }()
    
    private func configViewController() {
        view.backgroundColor = .white
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardShowing(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardHiding(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc func handleKeyboardShowing(sender notification: Notification) {
        guard let infoDict = notification.userInfo else { return }
        guard let rectFrame = infoDict[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let duration = infoDict[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
        loginLogoView.moveFramesToAccomodateKeyboard(with: rectFrame, and: duration)
    }
    
    @objc func handleKeyboardHiding(sender notification: Notification) {
        guard let infoDict = notification.userInfo else { return }
        guard let duration = infoDict[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
        loginLogoView.moveFramesToAccomodateKeyboard(with: CGRect.zero, and: duration)
    }

    func addSubviews() {
        view.addSubview(loginLogoView)
    }
    
    func configureConstraints() {
        let safeGuide = view.safeAreaLayoutGuide
        loginLogoView.translatesAutoresizingMaskIntoConstraints = false
        loginLogoView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        loginLogoView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        loginLogoView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        loginLogoView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
    }
    
    func customErrorMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
