//
//  UserDefaults.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import Foundation

extension UserDefaults {
    func getToken() -> String? {
        return self.string(forKey: "token")
    }
    
    func setToken(_ token: String) {
        set(token, forKey: "token")
    }
    
    func deleteToken() {
        removeObject(forKey: "token")
    }
}
