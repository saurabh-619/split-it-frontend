//
//  LocalStorageManager.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import Foundation

class LocalStorageManager {
    let shared = LocalStorageManager()
    let defaults = UserDefaults.standard
    
    private init() {}
    
    func get<T>(_ key: String, type: T.Type) -> T {
        switch type {
        case :
            return defaults.integer(forKey: key)
        case Bool.self:
            return defaults.bool(forKey: key)
        case String.self:
            return defaults.string(forKey: key)
        case default:
            return defaults.string(forKey: key)
        }
    }
}
