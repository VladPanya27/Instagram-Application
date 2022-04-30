//
//  StorageManager.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import Foundation

public class StorageManager {
    
  static let shared = StorageManager()
  
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL,Error>) -> Void) {
        
    }
    
    public func downloadImage(with referens: String, completion: @escaping (Result<URL,IGStorageManagerError>) -> Void) {
        bucket.child(referens).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
                completion(.success(url))
        }
    }
}

