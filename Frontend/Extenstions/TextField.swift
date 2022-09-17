//
//  TextField.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI

extension TextField {
    func keyboardDetails(isEmail: Bool = false) -> some View {
        self.modifier(TextFieldModifier(isEmail: isEmail))
    }
}
