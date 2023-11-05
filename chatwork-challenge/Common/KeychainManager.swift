//
//  KeychainManager.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/05.
//

import KeychainAccess

final class KeychainManager {
    
    // MARK: - Static
    
    static let shared = KeychainManager()
    
    // MARK: - Property
    
    let keychain = Keychain()
    
    func get(key: String) -> String? {
        return keychain[key]
    }
    
    func set(key: String, value: String) {
        keychain[key] = value
    }
}
