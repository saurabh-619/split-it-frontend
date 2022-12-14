//
//  LoginView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionState: SessionState
    @StateObject() private var vm = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    heading
                    Spacer()
                        .frame(height: 100)
                    loginFields
                    Spacer()
                        .frame(height:  UIScreen.screenHeight / 2 - 240)
                    footer
                }
                .padding(20)
                .backgroundColor()
            }
            .toastView(toast: $vm.toast)
            .navigationDestination(isPresented: $vm.takeHome) {
                HomeView()
                    .environmentObject(sessionState)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension LoginView {
    private var heading: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("let's sign you in.")
            .font(.system(size: 28, weight: .semibold))
            .foregroundColor(Color.theme.white45)

            VStack(alignment: .leading) {
                Text("welcome back.")
                Text("you've been missed!")
            }
            .font(.system(size: 36, weight: .bold))
        }
    }
    
    private var loginFields: some View {
        VStack(spacing: 24) {
            TextFieldView(placeholder: "username", text: $vm.username, errorMsg: vm.usernameErrorMsg)
            PasswordFieldView(placeholder: "password", password: $vm.password, isPasswordVisible: $vm.isPasswordVisible, errorMsg: vm.passwordErrorMsg)
        }
    }
    
    private var registerLink: some View {
        NavigationStack {
            HStack(spacing: 4) {
                Text("don't have an account? ")
                    .foregroundColor(Color.theme.gray400)
                NavigationLink(
                    destination: RegisterView()
                        .environmentObject(sessionState)
                ) {
                    Text("register")
                        .foregroundColor(Color.theme.appWhite)
                        .bold()
                }
            }
            .padding(.bottom, 10)
        }
    }
    
    private var signInButton: some View {
        ActionButtonView(text: "sign in", isLoading: vm.isLoading) {
            Task {
                let takeHome = await vm.login()
                await sessionState.getAuthUser()
                if(!sessionState.isFetching) {
                    try await Task.sleep(nanoseconds: 3_000_000_000)
                    vm.takeHome = takeHome
                }
            }
        }
    }
    
    private var footer: some View {
        VStack {
            registerLink
            signInButton
        }
    }
}
