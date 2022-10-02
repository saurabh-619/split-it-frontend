//
//  FrontendApp.swift
//  Frontend
//
//  Created by Saurabh Bomble on 13/09/22.
//

import SwiftUI

@main
struct FrontendApp: App {
    @AppStorage(AppStorageKeys.TOKEN) var token: String?
    
    @Environment(\.scenePhase) var scenePhase
    let persistenceManager = PersistenceManager.shared
    
    @StateObject var sessionState = SessionState()
    
    init() {
        UITextField.appearance().tintColor = UIColor(Color.theme.accent)
    }
    
    var body: some Scene {
        WindowGroup {
            if(token == nil) {
                LoginView()
                    .environmentObject(sessionState)
            } else {
                Tabbar()
                    .environmentObject(sessionState)
                    .environment(\.managedObjectContext, persistenceManager.container.viewContext)
                    .onAppear {
                        Task {
                           await sessionState.getAuthUser()
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch scenePhase {
            case .background:
                persistenceManager.save()
                print("core data saved in background")
            case .inactive:
                print("scene is inactive")
            case .active:
                print("scene is active")
            @unknown default:
                print("apple changed it's api")
            }
        }
    }
}
