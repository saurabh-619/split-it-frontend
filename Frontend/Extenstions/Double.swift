//
//  Double.swift
//  Frontend
//
//  Created by Saurabh Bomble on 02/10/22.
//

import Foundation

extension Double {
    var getZeroDigitString: String {
        return String(format: "%.0f", self)
    }
    
    var getOneDigitString: String {
        return String(format: "%.1f", self)
    }
    
    var getTwoDigitString: String {
        return String(format: "%.2f", self)
    }
    
    var getThreeDigitString: String {
        return String(format: "%.3f", self)
    }
}
