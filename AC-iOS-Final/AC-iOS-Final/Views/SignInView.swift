//
//  SignInView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class SignInView: UIView {
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Email..."
        tf.backgroundColor = UIColor.init(red: 218/255, green: 218/255, blue: 223/255, alpha: 1)
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Password.."
        tf.keyboardType = .default
        tf.backgroundColor = UIColor.init(red: 218/255, green: 218/255, blue: 223/255, alpha: 1)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login / ", for: .normal)
        button.setTitleColor(UIColor.init(red: 116/255, green: 196/255, blue: 247/255, alpha: 1), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.init(red: 116/255, green: 196/255, blue: 247/255, alpha: 1), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.horizontal
        stView.distribution  = .fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 0.0
        return stView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    override func layoutSubviews() {
        emailTextField.setNeedsLayout()
        passwordTextField.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInit() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(32)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.height.equalTo(32)
        }
        
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.height.equalTo(32)
        }
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalTo(snp.centerX)
        }
        
        buttonsStackView.addArrangedSubview(loginButton)
        buttonsStackView.addArrangedSubview(registerButton)
    }
}
