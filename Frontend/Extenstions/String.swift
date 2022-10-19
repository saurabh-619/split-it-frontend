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
    
    func daySuffix(dayOfMonth: Int) -> String {
            switch dayOfMonth {
            case 1, 21, 31:
                return "st"
            case 2, 22:
                return "nd"
            case 3, 23:
                return "rd"
            default:
                return "th"
            }
    }
    
    var dateFromISOMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let dateDate = dateFormatter.date(from: self)!
        
        let dayOfMonth = Calendar.current.dateComponents([.day], from: dateDate)
        let suffix = daySuffix(dayOfMonth: dayOfMonth.day!)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd'\(suffix)' MMMM yyyy"
        let date = formatter.string(from: dateDate)
        return date
    }
}

