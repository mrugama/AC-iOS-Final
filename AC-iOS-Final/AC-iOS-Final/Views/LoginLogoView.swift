//
//  LoginLogoView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

@objc protocol LoginDelegate: class {
    @objc optional func didSignInButtonPressed(_ email: String, _ password: String)
    @objc optional func didSignUpButtonPressed(_ userName: String, _ email: String, _ password: String)
}

class LoginLogoView: UIView {
    
    weak var delegate: LoginDelegate?

    var signInView = SignInView()
    var signUpView = SignUpView()
    private var authUserService = AuthUserService()
    
    public func moveFramesToAccomodateKeyboard(with rect: CGRect, and animationDuration: Double) {
        logoTopConstraint.constant = -(rect.height + 20)
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
    }
    
    private var logoTopConstraint = NSLayoutConstraint()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "meatly_logo")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
        configInit()
        signInView.registerButton.addTarget(self, action: #selector(flipToSignUp), for: .touchUpInside)
        signInView.loginButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        signUpView.loginButton.addTarget(self, action: #selector(goBackSignInView), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
    
    @objc private func signUpButtonPressed() {
        guard let userName = signUpView.userTextField.text else {print("Empty userName");return}
        guard let email = signUpView.emailTextField.text else {print("Empty email"); return}
        guard let password = signUpView.passwordTextField.text else {print("Empty password"); return}
        delegate?.didSignUpButtonPressed?(userName, email, password)
        goBackSignInView()
    }
    
    @objc private func signInButtonPressed() {
        guard let email = signInView.emailTextField.text else {print("Empty email"); return}
        guard let password = signInView.passwordTextField.text else {print("Empty password"); return}
        print("SignIn button pressed")
        delegate?.didSignInButtonPressed?(email, password)
    }
    
    @objc private func goBackSignInView() {
        UIView.transition(from: signUpView,
                          to: signInView,
                          duration: 1.0,
                          options: [.transitionFlipFromLeft,
                                    .showHideTransitionViews],
                          completion: { isAnimated in
                            self.signUpView.isHidden = true
        })
    }
    
    private func configInit() {
        signUpView.isHidden = true
    }

    @objc private func flipToSignUp() {
        UIView.transition(from: signInView,
                          to: signUpView,
                          duration: 1.0,
                          options: [.transitionFlipFromRight,
                                    .showHideTransitionViews],
                          completion: { isAnimated in
                            self.signInView.isHidden = true
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInit() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32)
        logoTopConstraint.isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.80).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.80).isActive = true
//        logoImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(snp.top).offset(32)
//            make.centerX.equalTo(snp.centerX)
//            make.width.height.equalTo(snp.width).multipliedBy(0.8)
//        }
        
        addSubview(signUpView)
        signUpView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom)
            make.width.equalTo(logoImageView.snp.width)
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(signInView)
        signInView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom)
            make.width.equalTo(logoImageView.snp.width)
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
}
