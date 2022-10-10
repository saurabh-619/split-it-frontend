//
//  RequestMoneyViewRequest.swift
//  Frontend
//
//  Created by Saurabh Bomble on 10/10/22.
//

import Foundation


struct RequestMoneyViewRequest: Encodable {
    let title: String
    let description: String
    let amount: Int
    let requesteeId: Int
}
