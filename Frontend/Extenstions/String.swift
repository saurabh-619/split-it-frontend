//
//  String.swift
//  Frontend
//
//  Created by Saurabh Bomble on 29/09/22.
//

import Foundation

extension String {
    var dateFromISO: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let dateDate = dateFormatter.date(from: self)!
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd MMM yy 'at' hh:mm a"
        let date = formatter.string(from: dateDate)
        return date
    }
}

