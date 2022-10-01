//
//  AppButtonView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI

struct ActionButtonView: View {
    let text: String
    var height = 60.0
    var fontSize = 16.0
    var fontColor = Color.theme.background
    var bgColor = Color.theme.accent
    var cornerRadius = 14.0
    var isLoading = false
    var isDisabled = false
    
    var onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            if(isLoading) {
                WhiteSpinner()
                    .frame(height: 40)
                    .frame(maxWidth: 30)
            } else {
                Text(text)
                .font(.system(size: fontSize, weight: .bold))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .foregroundColor(isDisabled ? Color.theme.gray400 : fontColor)
        .background(isDisabled ? Color.theme.gray900 : bgColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .disabled(isDisabled)
    }
}

struct AppButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(text: "sign in") {}
            .preferredColorScheme(.dark)
    }
}
