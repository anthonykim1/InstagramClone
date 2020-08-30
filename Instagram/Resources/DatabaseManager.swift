//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Anthony Kim on 8/26/20.
//  Copyright © 2020 Anthony Kim. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    // functions that auth manager is going to user
    
    /// Check if username and email is available
    /// - Paramters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true) // implement later
    }
    
    /// Inserts new user data to database
    /// - Paramters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
   
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                // success
                completion(true)
                return
            }else{
                // failed
                completion(false)
                return
            }
            
        }
    }
    
    // MARK: Private
    

   
    
}
