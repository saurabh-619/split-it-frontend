//
//  ToastModifier.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/09/22.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                ZStack() {
                    if let toast {
                        VStack {
                            ToastView(type: toast.type, title: toast.title, message: toast.message) {
                                dismissToken()
                            }
                            Spacer()
                        }
                        .transition(.asymmetric(insertion: .offset(y: 0), removal: .offset(y: -300))) 
                    }
                }
            }
            .onChange(of: toast) { _ in
                showToast()
            }
    }
    
    
    private func showToast() {
        guard let toast = toast else { return }
        
        if(toast.duration > 0) {
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
                dismissToken()
            }
        }
    }
    
    private func dismissToken() {
        withAnimation(.easeInOut(duration: 0.5)) {
            toast = nil
        }
    }
}
