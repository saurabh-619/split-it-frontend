//
//  AlertView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 08/10/22.
//

import SwiftUI

struct AlertView: View {
    let title: String
    let msg: String?
    var placeholder: String = ""
    
    @Binding var isShown: Bool
    @Binding var text: String
    
    var onSubmit: () -> Void = {}
    var onCancel: () -> Void = {}
    
        
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.theme.appWhite)
                .padding(.bottom, 4)
            
            if let msg = msg {
                Text(msg)
                    .font(.callout)
                    .foregroundColor(Color.theme.white45)
            }
         
            TextFieldView(placeholder: placeholder, text: $text)
                .padding(.top, 24)
                .padding(.bottom, 18)
            
            HStack {
                Button {
                    onCancel()
                    isShown = false
                } label: {
                    Text("cancel")
                        .font(.callout)
                        .foregroundColor(Color.theme.gray300)
                }
                Spacer()
                ActionButtonView(text: "add", height: 48, onClick: onSubmit)
                    .frame(width: 120)
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 28)
        .background(Color.theme.darkerGray)
        .clipShape(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        )
        .offset(y: isShown ? 0 : UIScreen.screenHeight)
        .animation(.spring(), value: isShown)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(title: "remark", msg: nil, isShown: .constant(true), text: .constant(""))
            .preferredColorScheme(.dark)
    }
}
