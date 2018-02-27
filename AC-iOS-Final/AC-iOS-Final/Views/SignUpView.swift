//
//  SignUpView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class SignUpView: UIView {

    lazy var userTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User name..."
        tf.backgroundColor = UIColor.init(red: 218/255, green: 218/255, blue: 223/255, alpha: 1)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Email..."
        tf.backgroundColor = UIColor.init(red: 218/255, green: 218/255, blue: 223/255, alpha: 1)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Password.."
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
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(UIColor.init(red: 116/255, green: 196/255, blue: 247/255, alpha: 1), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInit() {
        addSubview(userTextField)
        userTextField.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(32)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.height.equalTo(32)
        }
        
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userTextField.snp.bottom).offset(16)
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
        buttonsStackView.addArrangedSubview(signUpButton)
    }
}
