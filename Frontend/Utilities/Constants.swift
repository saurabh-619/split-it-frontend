//
//  Constants.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import Foundation

struct ApiConstants {
    // login and register
    static let LOGIN_URL = "http://localhost:3000/auth/login"
    static let REGISTER_URL = "http://localhost:3000/auth/register"
    static let USERNAME_AVAILABLE_URL = "http://localhost:3000/user/is-available?username"
    
    // profile
    static let AUTH_USER_URL = "http://localhost:3000/auth"
    
    // user
    static let EDIT_PROFILE_URL = "http://localhost:3000/user"
    static let SEARCH_USERS = "http://localhost:3000/user/search?query"
    static let SEARCH_USER_WITH_FRIENDSHIP_STATUS = "http://localhost:3000/user"
    
    // friends
    static let GET_FRIENDS = "http://localhost:3000/friend-request/friends"
    static let GET_FRIEND_REQUESTS = "http://localhost:3000/friend-request"
    static let CHANGE_FRIEND_REQUEST_STATUS = "http://localhost:3000/friend-request"
    static let SEND_FRIEND_REQUEST = "http://localhost:3000/friend-request"
    
    // money requests
    static let MONEY_REQUESTS_TO_ME = "http://localhost:3000/money-request/to-me?status"
    static let MONEY_REQUESTS_BY_ME = "http://localhost:3000/money-request/by-me?status"
    static let MONEY_REQUESTS_EDIT = "http://localhost:3000/money-request"
    static let MONEY_REQUEST_STATUS_UPDATE = "http://localhost:3000/money-request"
    static let SEND_MONEY_REQUEST = "http://localhost:3000/money-request"
}

struct AppStorageKeys {
    static let TOKEN = "token"
}

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
