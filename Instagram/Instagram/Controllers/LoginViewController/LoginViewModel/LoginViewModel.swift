//
//  LoginViewModel.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import Foundation
import SafariServices
import FirebaseAuth

class LoginViewModel {
    
    func checkEmailAndPassword(email: String?, password: String?) {
    guard let usernameEmail = email, !usernameEmail.isEmpty,
          let password = password, !password.isEmpty, password.count >= 8 else {return}
    }

    func loadUrl(completion: @escaping (URL) -> Void) {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {return}
        completion(url)
    }
    
    func signInUser(usernames: String?, email: String?, password: String, completion: @escaping(Bool) -> Void) {
        guard let usernameEmail = email else {return}
        
        var username:String?
        var email:String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
        FirebaseAuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            if success {
                completion(true)
            } else {
                // error
               completion(false)
            }
        }
    }
}
