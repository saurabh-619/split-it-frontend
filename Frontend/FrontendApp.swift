//
//  FrontendApp.swift
//  Frontend
//
//  Created by Saurabh Bomble on 13/09/22.
//

import SwiftUI

@main
struct FrontendApp: App {
    
    init() {
        UITextField.appearance().tintColor = UIColor(Color.theme.accent)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
