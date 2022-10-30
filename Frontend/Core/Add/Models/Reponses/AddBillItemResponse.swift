//
//  AddBillItemReponse.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/10/22.
//

import Foundation

struct AddBillItemResponse: CoreResponse, Decodable {
    let ok: Bool
    let status: Int
    let error: String?
    let billId: Int
    let billItemId: Int
}
