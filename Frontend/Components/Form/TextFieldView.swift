 //
//  TextFieldView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var text: String
    var isEmail = false
    var isNumber = false
    var bgColor = Color.theme.gray1000
    var borderColor = Color.theme.white30
    var cornerRadius = 12.0
    var horizontalPad = 20.0
    var height = 60.0
    
    var haveSpinner = false
    var errorMsg: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .trailing) {
                TextField(placeholder, text: $text)
                    .keyboardDetails(isEmail: isEmail, isNumber: isNumber)
                
                if(haveSpinner) {
                    AccentSpinner()
                        .frame(height: 40)
                        .frame(maxWidth: 30)
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

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeholder: "some text", text: .constant("yo"), errorMsg: "bro wth")
            .preferredColorScheme(.dark)
    }
}
