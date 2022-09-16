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
                .fill(isHoveringClose ? Color.theme.white80 : Color.clear)
                .cornerRadius(8)
                .frame(width: 30, height: 30)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 13))
                        .onTapGesture {
                            onClose()
                            isHoveringClose.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                isHoveringClose.toggle()
                            }
                        }
                        .foregroundColor(isHoveringClose ? Color.black : Color.theme.white30)
                        .fontWeight(.bold),
                    alignment: .center
                )
        }
        .padding(16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(minHeight: 90)
        .background(
            LinearGradient(colors: [type.shadowColor.opacity(0.2), type.shadowColor.opacity(0.01)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .backgroundColor()
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
        .preferredColorScheme(.dark)
    }
}
