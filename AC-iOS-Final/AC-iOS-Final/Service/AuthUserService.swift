//
//  AuthUserService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Firebase

@objc protocol AuthUserServiceDelegate: class {
    // create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ userService: AuthUserService, user: User)
    
    // sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    // sign in delegate protocols
    @objc optional func didFailToSignIn(_ userService: AuthUserService, error: Error)
    @objc optional func didFailToEmailVerify(_ userService: AuthUserService, user: User, error: Error?)
    @objc optional func didSignIn(_ userService: AuthUserService, user: User)
    @objc optional func didUserUpdateInfoFail(_ userService: AuthUserService, user: User, error: Error)
}

class AuthUserService: NSObject {
    weak var delegate: AuthUserServiceDelegate?
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(userName: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
                return
            }
            
            if let user = user {
                let userProfile = user.createProfileChangeRequest()
                userProfile.displayName = userName
                userProfile.commitChanges(completion: { (error) in
                    if let error = error {
                        self.delegate?.didUserUpdateInfoFail?(self, user: user, error: error)
                        return
                    } else {
                        user.sendEmailVerification(completion: { (error) in
                            if let error = error {
                                self.delegate?.didFailToEmailVerify?(self, user: user, error: error)
                                return
                            }
                        })
                        self.delegate?.didCreateUser?(self, user: user)
                    }
                })
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
            return
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailToSignIn?(self, error: error)
                return
            } else if let user = user {
                if !user.isEmailVerified {
                    self.delegate?.didFailToEmailVerify?(self, user: user, error: nil)
                } else {
                    self.delegate?.didSignIn?(self, user: user)
                }
            }
        }
    }
}
