//
//  SplitInput.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/10/22.
//

import Foundation
import SwiftUI

struct SplitInput: Equatable {
    static func == (lhs: SplitInput, rhs: SplitInput) -> Bool {
        lhs.friendId == rhs.friendId
    }
    
    var friendId: Int
    var splitString: Binding<String>?
    var split: Int?
}
