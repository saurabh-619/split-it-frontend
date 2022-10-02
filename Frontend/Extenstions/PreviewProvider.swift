//
//  PreviewProvider.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init(){}
    
    var wallet: Wallet {
        Wallet(id: 1, version: 1, ownerId: 1, balance: 5000, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var user: User {
        User(id: 1, version: 1, username: "jon", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: self.wallet, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var userWithoutWallet: User {
        User(id: 1, version: 1, username: "jon", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: nil, createdAt: "", updatedAt: "", deletedAt: "")
    }
    
    var friends: [User] {
        var friends = [User]()
        for id in 1..<15 {
            friends.append(User(id: id, version: 1, username: "jon", firstName: "Jon", lastName: "Doe", email: "jon@gmail.com", avatar: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80", walletId: 1, wallet: nil, createdAt: "", updatedAt: "", deletedAt: "")
            )
        }
        return friends
    }
    var moneyRequest: MoneyRequest {
        MoneyRequest(id: 7, version: 12, createdAt: "2022-09-06T08:10:56.648Z", updatedAt: "2022-09-06T08:45:06.147Z", deletedAt: nil, title: "[No Test] bro need some 100 bucks", description: "[No Test] I am gonna buy a fresh bike and for the very reason need 100 bucks. Your help will be appreciated.", amount: 5000, status: "paid", requesteeRemark: nil, requester: User(id: 9, version: 8, username: "test", firstName: "Test", lastName: "TDD", email: "test@gmail.com", avatar: "https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTczNDV8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NjE2ODk2NzU&ixlib=rb-1.2.1&q=80&w=1080", walletId: 5, wallet: nil, createdAt: "2022-08-28T12:27:55.307Z", updatedAt: "2022-08-28T12:50:00.462Z", deletedAt: ""), requestee: User(id: 7, version: 1, username: "saurabh", firstName: "Saurabh", lastName: "Bomble", email: "saurabh@gmail.com", avatar: "https://images.unsplash.com/photo-1522778147829-047360bdc7f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNTczNDV8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NjE2MzUzODM&ixlib=rb-1.2.1&q=80&w=1080", walletId: 3, wallet: nil, createdAt: "2022-08-27T21:23:03.244Z", updatedAt: "2022-08-27T21:23:03.244Z", deletedAt: ""), requesterId: 9, requesteeId: 7)

    }
    var friendRequests: [FriendRequestWithRequester] {
        var requests = [FriendRequestWithRequester]()
        for id in 1..<self.friends.count {
            requests.append(FriendRequestWithRequester(id: id, requester: self.friends[id]))
        }
        return requests
    }
    
    var moneyRequests: [MoneyRequest] {
        var requests = [MoneyRequest]()
        
        for id in 1..<15 {
            var request = moneyRequest
            request.id = id
            requests.append(request)
        }
        return requests
    }
}
