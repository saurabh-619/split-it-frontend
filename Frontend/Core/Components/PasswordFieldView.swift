//
//  PasswordField.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/09/22.
//

import SwiftUI

struct PasswordFieldView: View {
    var title: String
    @Binding var password: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        ZStack {
            if !isPasswordVisible {
                SecureField(title, text: $password)
            } else {
                TextField(title, text: $password) 
            }
            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .onTapGesture {
                    isPasswordVisible.toggle() 
                }
        }
    }
}

struct PasswordFieldView_Preview: PreviewProvider {
    static var previews: some View {
        PasswordFieldView(title: "password", password: .constant("12345"), isPasswordVisible: .constant(false))
    }
}
