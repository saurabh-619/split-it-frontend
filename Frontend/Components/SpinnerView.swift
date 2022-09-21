//
//  Spinner.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI

struct AccentSpinner: View {
    var body: some View {
        LottieView(animationName: "accent-spinner", loopMode: .loop, contentMode: .scaleAspectFill)
    }
}

struct WhiteSpinner: View {
    var body: some View {
        LottieView(animationName: "app-white-spinner", loopMode: .loop, contentMode: .scaleAspectFill)
    }
}
    
