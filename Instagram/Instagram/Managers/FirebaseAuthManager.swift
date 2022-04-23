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
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping(Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }

    public func logOut(completion:(Bool) -> Void) {

        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}

