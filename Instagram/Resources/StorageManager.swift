//
//  StorageManager.swift
//  Instagram
//
//  Created by Anthony Kim on 8/26/20.
//  Copyright © 2020 Anthony Kim. All rights reserved.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    // add function just like database and auth manager where our entire app can use it directly
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void){
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}

public enum UserPostType{
    case photo, video
}

public struct UserPost{
    let postType: UserPostType
}
