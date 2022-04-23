//
//  SafeEmail.swift
//  Instagram
//
//  Created by Vlad Panchenko on 21.04.2022.
//

import Foundation

class SafeEmail {
    static func safeDatabaseKey(with email: String) -> String {
            return email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        }
    }

