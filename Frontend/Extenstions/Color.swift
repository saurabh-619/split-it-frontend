//
//  Color.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/09/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("Accent")
    let background = Color("Background")
    let appWhite = Color("AppWhite")
    let cardBackground = Color("CardBackground")
    let toastBorder = Color("ToastBorder")
    let gray = Color("Gray")
    let darkGray = Color("DarkGray")
    
    let white15 = Color.white.opacity(0.15)
    let white30 = Color.white.opacity(0.30)
    let white45 = Color.white.opacity(0.45)
    let white60 = Color.white.opacity(0.60)
    let white80 = Color.white.opacity(0.80)
    
    let infoBg = Color("toast.bg.info")
}
