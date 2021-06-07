//
//  FirebaseService.swift
//  Services
//
//  Created by Kacper Jagiełło on 07/06/2021.
//

import Foundation
import FirebaseCore

public protocol HasFirebaseService {
    var firebaseService: FirebaseServing { get }
}

public class FirebaseService {
    public init() {
        configureFirebaseIfNeeded()
    }
    
    private func configureFirebaseIfNeeded() {
        guard FirebaseApp.app() == nil else { return }
        FirebaseApp.configure()
    }
}

public protocol FirebaseServing { }

extension FirebaseService: FirebaseServing { }
