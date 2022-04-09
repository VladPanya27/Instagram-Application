//
//  FirebaseAuth.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import Foundation
import FirebaseAuth
import UIKit

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    public func checkUser(window: UIWindow) {
        if Auth.auth().currentUser != nil {
            window.rootViewController = TabBarViewController()
        } else {
            window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
    }
    
    public func registerNewUser(username: String, email: String, password: String) {
        
    }
    
    public func loginUser(username: String?, email: String, password: String) {
        
    }

}
