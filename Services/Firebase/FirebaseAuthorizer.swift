//
//  FirebaseAuthorizer.swift
//  Services
//
//  Created by Kacper Jagiełło on 07/06/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//public struct User {
//    let username: String
//    let emailAdress: String
//    let password: String
//}

public protocol HasFirebaseAuthorizer {
    var firebaseAuthorizer: FirebaseAuthorizing { get }
}

public class FirebaseAuthorizer: FirebaseAuthorizing {
    private let database: Firestore
    
    public init() {
        self.database = Firestore.firestore()
    }
    
    public func createUser(_ user: User) {
        print("createUser")
    }
    
//    public func createUser(
//        _ user: User
//    ) {
//        Auth.auth().createUser(
//            withEmail: user.emailAdress,
//            password: user.password
//        ) { [weak self] result, error in
//            if error != nil {
//                print("Error:", error?.localizedDescription)
//            }
//            guard let result = result else { return }
//            self?.addUserToTheDatabase(
//                id: result.user.uid,
//                user: user
//            )
//        }
//    }
//
//    private func addUserToTheDatabase(
//        id: String,
//        user: User
//    ) {
//        database.collection("users").addDocument(
//            data: [
//                "email_adress": user.emailAdress,
//                "username": user.username,
//                "password": user.password,
//                "uid": id
//            ]
//        ) { error in
//            print("Error:", error?.localizedDescription)
//        }
//    }
    
    // MARK: - TODO
    public func signIn() {
        print("sign in")
    }
}

public protocol FirebaseAuthorizing {
    func createUser(_ user: User)
    func signIn()
}
