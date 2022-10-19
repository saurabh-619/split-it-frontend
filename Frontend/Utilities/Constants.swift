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
    
    // bill list
    static let GET_LEADER_BILLS = "http://localhost:3000/bill?limit=10000"
    static let GET_SPLIT_BILLS = "http://localhost:3000/bill/split?limit=10000"
    static let SETTLE_THE_SPLIT = "http://localhost:3000/bill/pay-the-split"
    
    // transactions
    static let GET_TRANSACTIONS = "http://localhost:3000/transaction?page=1&limit=10000"
}

struct AppStorageKeys {
    static let TOKEN = "token"
}
