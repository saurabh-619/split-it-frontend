//
//  RegisterView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var vm = RegisterViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                heading
                Spacer(minLength: 100)
                registerFields
                footer
            }
            .padding(20)
            .backgroundColor()
            .toastView(toast: $vm.toast)
        }
        .navigationBarBackButtonHidden()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .preferredColorScheme(.dark)
    }
}

extension RegisterView {
    private var heading: some View {
        Group {
            Text("splitit")
                .font(.system(size: 32, weight: .semibold))
                .foregroundColor(Color.theme.white45)
                .padding(.bottom, 1)
            
            Text("makes it easier for friends to split and track bills")
                .font(.system(size: 40, weight: .bold))
        }
    }
    
    private var registerFields: some View {
        EmptyView()
    }
    
    private var signInLink: some View {
        HStack {
            Text("already have an account? ")
                .foregroundColor(Color.theme.gray400)
            Text("sign in")
                .foregroundColor(Color.theme.appWhite)
                .bold()
                .onTapGesture {
                    dismiss()
                }
        }
    }
    
    private var registerButton: some View {
        ActionButtonView(text: "register") {
            Task {
                await vm.register()
            }
        }
    }
    
    private var footer: some View {
        VStack {
            signInLink
            registerButton
        }
    }
}
