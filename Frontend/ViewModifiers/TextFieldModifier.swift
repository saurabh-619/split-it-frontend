//
//  TextFieldModifier.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI
 
struct TextFieldModifier: ViewModifier {
    let isEmail: Bool
    
    func body(content: Content) -> some View {
        content
            .keyboardType(isEmail ? .emailAddress : .default)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}
