//
//  Toast.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import Foundation
import SwiftUI

enum ToastStyle {
    case info
    case success
    case warning
    case error
}


extension ToastStyle {  
    var shadowColor: Color {
        switch self {
        case .info: return Color.blue.opacity(0.7)
        case .success: return Color.green.opacity(0.7)
        case .warning: return Color.yellow.opacity(0.7)
        case .error: return Color.red.opacity(0.7)
        }
    }
    
    var icon: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .info: return Color.blue.opacity(0.9)
        case .success: return Color.green.opacity(0.9)
        case .warning: return Color.yellow.opacity(0.9)
        case .error: return Color.red.opacity(0.9)
        }
    }
}

struct Toast: Equatable {
    var type: ToastStyle = ToastStyle.success
    var title: String
    var message: String
    var duration: Double = 3.0
}
