//
//  UserProvider.swift
//  Services
//
//  Created by Kacper Jagiello on 08/06/2021.
//

import Combine
import FirebaseAuth

public protocol UserProviding {
    func signIn(
        withEmail email:String,
        password: String
    ) -> AnyPublisher<Void, Error>
    func signInAnonymously() -> AnyPublisher<User, Error>
    func currentUser() -> AnyPublisher<User?, Never>
    func signOut() -> AnyPublisher<Void, Error>
}

public protocol HasUserProvider {
    var userProvider: UserProviding { get }
}

public struct UserProvider: UserProviding {
    public init() { }
    
    public func currentUser() -> AnyPublisher<User?, Never> {
        return Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    public func signInAnonymously() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    return promise(.failure(error))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func signIn(
        withEmail email:String,
        password: String
    ) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            Auth.auth().signIn(
                withEmail: email,
                password: password
            ) { _, error in
                if let error = error {
                    print(error.localizedDescription)
                    return promise(.failure(error))
                } else {
                    print("Logged in succesfully.")
                    return promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func signOut() -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                print(error.localizedDescription)
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
