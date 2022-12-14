//
//  View.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import Foundation
import SwiftUI

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
    
    func backgroundColor() -> some View {
        self.modifier(BackgroundModifier())
    }
    
    func adaptsToKeyboard() -> some View {
        self.modifier(AdaptsToKeyboardModifier())
    }
}
