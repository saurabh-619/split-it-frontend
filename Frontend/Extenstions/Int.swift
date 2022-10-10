//
//  Int.swift
//  Frontend
//
//  Created by Saurabh Bomble on 05/10/22.
//

import Foundation

extension Int {
    var withCommasString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_IN")
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
