//
//  Types.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/10/22.
//

import Foundation


enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum Screen {
    case HOME
    case WALLET
    case ADD
    case BILLS
    case PROFILE
}

enum FriendRequestStatus: String {
    case SEEN = "seen"
    case PENDING = "pending"
    case ACCEPTED = "accepted"
    case REJECTED = "rejected"
    case UNFRIENDED = "unfriended"
}

enum MoneyRequestStatus: String, CaseIterable, Identifiable {
    case PENDING = "pending"
    case ACCEPTED = "accepted"
    case REJECTED = "rejected"
    case PAID = "paid"
    case SEEN = "seen"
    
    var id: String {
        self.rawValue
    }
}

enum TransactionType: String, CaseIterable, Identifiable {
    case BILL = "bill"
    case SPLIT = "split"
    case WALLET = "wallet"
    
    var id: String {
        self.rawValue
    }
}

enum TransactionState: String, CaseIterable, Identifiable {
    case PENDING = "pending"
    case PAID = "paid"
    
    var id: String {
        self.rawValue
    }
}
