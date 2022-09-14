//
//  ToastView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import SwiftUI

struct ToastView: View {
    var type: ToastStyle
    var title: String
    var message: String
    var onClose: () -> Void = {}
    
    @State private var isHoveringClose = false
    
    var body: some View {
        HStack(alignment: .center) {
            Circle()
                .fill(type.iconColor)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: type.icon)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(type.iconColor, .white)
                        .font(.system(size: 26))
                }
                .shadow(color: type.shadowColor, radius: 15, x: 3, y: 6)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .bold()
                
                Text(message)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding(.horizontal, 10)
            .frame(width: 250, alignment: .leading)
            
            Spacer()
            
            Rectangle()
                .fill(isHoveringClose ? .white : .clear)
                .cornerRadius(12)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "xmark")
                        .onTapGesture {
                            onClose()
                            isHoveringClose.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                isHoveringClose.toggle()
                            }
                        }
                        .foregroundColor(isHoveringClose ? .black : .black.opacity(0.35))
                        .fontWeight(.bold),
                    alignment: .center
                )
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: 90)
        .background(type.bgColor)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ToastView(type: .success, title: "congratulations!", message: "you have succefully logged in")
            ToastView(type: .info, title:"new feature", message: "you can now ask your friend for money")
            ToastView(type: .warning, title:"New volume!", message: "your subscription ends in 2 days")
            ToastView(type: .error, title:"oops!", message: "couldn't logged in")
        }
    }
}
