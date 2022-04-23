//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
        
    public func canCreateNewUser(with email: String, username:String, completion: (Bool) -> Void) {
        completion(true)
    }

    public func insertNewUser(with email: String, username:String, completion: @escaping (Bool) -> Void) {
        database.child(SafeEmail.safeDatabaseKey(with: email)).setValue(["username": username]) { error, snapshot in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
