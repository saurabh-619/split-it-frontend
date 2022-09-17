//
//  BackgroundModifier.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/09/22.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.theme.background)
    }
}
