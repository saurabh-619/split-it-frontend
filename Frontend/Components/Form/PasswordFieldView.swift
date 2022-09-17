//
//  PasswordField.swift
//  Frontend
//
//  Created by Saurabh Bomble on 16/09/22.
//

import SwiftUI

struct PasswordFieldView: View {
    let placeholder: String
    var bgColor = Color.theme.gray1000
    var borderColor = Color.theme.white30
    var cornerRadius = 12.0
    var horizontalPad = 20.0
    var height = 60.0
    
    @Binding var password: String
    @Binding var isPasswordVisible: Bool
    
    var errorMsg: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .trailing) {
                if !isPasswordVisible {
                    SecureField(placeholder, text: $password)
                } else {
                    TextField(placeholder, text: $password)
                }
                
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isPasswordVisible.toggle()
                    }
            }
            .padding(.horizontal, horizontalPad)
            .frame(height: height)
            .background(bgColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(borderColor)
            )
            ValidationErrorView(errorMsg: errorMsg)
        }
    }
}

struct PasswordFieldView_Preview: PreviewProvider {
    static var previews: some View {
        PasswordFieldView(placeholder: "password", password: .constant("12345"), isPasswordVisible: .constant(false), errorMsg: "password bro wth")
    }
}
