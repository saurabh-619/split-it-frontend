//
//  Tab.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import Foundation


struct Tab {
    let icon: String
    let title: String
    let screen: Screen
    
    static let tabs = [
        Tab(icon: "home", title: "home", screen: Screen.HOME),
        Tab(icon: "wallet", title: "wallet", screen: Screen.WALLET),
        Tab(icon: "plus", title: "transaction", screen: Screen.ADD),
        Tab(icon: "credit-card", title: "bills", screen: Screen.BILLS),
        Tab(icon: "user", title: "profile", screen: Screen.PROFILE)
    ]
}
