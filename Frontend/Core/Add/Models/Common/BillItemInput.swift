//
//  BillItemInput.swift
//  Frontend
//
//  Created by Saurabh Bomble on 22/10/22.
//

import Foundation

struct BillItemInput: Identifiable, Encodable, Equatable {
    var id = UUID()
    
    let billId: Int?
    let name:  String
    let description: String
    let price: Int
    let friendIds: [Int]
    let quantity: Int
}
