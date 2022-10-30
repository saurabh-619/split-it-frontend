//
//  SplitInput.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/10/22.
//

import Foundation

class SplitInput: ObservableObject {
    var friendId: Int
    var split: Int?
    @Published var splitString: String = "0"
    
    init(friendId: Int, split: Int? = nil, splitString: String) {
        self.friendId = friendId
        self.split = split
        self.splitString = splitString
    }
}
