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
    
    let danger = Color.red.opacity(0.85)
    let success = Color.green.opacity(0.85)
    let info = Color.blue.opacity(0.85)
    let warning = Color.yellow.opacity(0.85)
    
    let darkGray = Color("DarkGray")
    let darkerGray = Color("DarkerGray")
    
    let gray = Color("Gray")
    let gray300 = Color("Gray300")
    let gray400 = Color("Gray400")
    let gray500 = Color("Gray500")
    let gray600 = Color("Gray600")
    let gray700 = Color("Gray700")
    let gray800 = Color("Gray800")
    let gray900 = Color("Gray900")
    let gray1000 = Color("Gray1000")
    
    
    let white5 = Color.white.opacity(0.05)
    let white15 = Color.white.opacity(0.15)
    let white30 = Color.white.opacity(0.30)
    let white45 = Color.white.opacity(0.45)
    let white60 = Color.white.opacity(0.60)
    let white80 = Color.white.opacity(0.80)
    
    let infoBg = Color("toast.bg.info")
}
