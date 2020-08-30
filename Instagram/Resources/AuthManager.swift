//
//  AuthManager.swift
//  Instagram
//
//  Created by Anthony Kim on 8/26/20.
//  Copyright © 2020 Anthony Kim. All rights reserved.
//

import FirebaseAuth
import Foundation
public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
         */

        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate{
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else{
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }else{
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                        
                    }
                }
            }else{
                // either username or email does not exist
                completion(false)
            }
        }
    }
    
    // escaping bc we used completion inside of another closure and as a result, the scope needs to escape
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        // figureout if the user is logging in with username or email
        if let email = email{
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error  in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }else if let user = username {
            // username log in
            print(username)
        }
    }
    
}
