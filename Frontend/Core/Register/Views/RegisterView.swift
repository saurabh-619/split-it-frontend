//
//  RegisterView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterViewModel()
    @EnvironmentObject private var sessionState: SessionState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    heading
                    Spacer()
                        .frame(height: 45)
                    registerFields
                    Spacer()
                        .frame(height: 65)
                    footer
                }
                .padding(20)
                .backgroundColor()
            }
            .toastView(toast: $vm.toast)
            .navigationDestination(isPresented: $vm.takeHome, destination: {
                HomeView()
                    .environmentObject(sessionState)
            })
            .navigationBarBackButtonHidden()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(SessionState())
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
        VStack(spacing: 24) {
            TextFieldView(placeholder: "first name", text: $vm.firstName, errorMsg: vm.firstNameError)
            TextFieldView(placeholder: "last name", text: $vm.lastName, errorMsg: vm.lastNameError)
            TextFieldView(placeholder: "email", text: $vm.email, isEmail: true, errorMsg: vm.emailError)
            TextFieldView(placeholder: "username", text: $vm.username, haveSpinner: vm.isUsernameSearching, errorMsg: vm.usernameError)
            PasswordFieldView(placeholder: "password", hasEye: false, password: $vm.password, isPasswordVisible: .constant(false), errorMsg: vm.passwordError)
            PasswordFieldView(placeholder: "confirm password", password: $vm.confirmPassword, isPasswordVisible: $vm.isPasswordVisible, errorMsg: vm.confirmPasswordError)
        }
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
        .padding(.bottom, 10)
    }
    
    private var registerButton: some View {
        ActionButtonView(text: "register", isLoading: vm.isLoading) {
            Task {
                let takeHome = await vm.register()
                await sessionState.getAuthUser()
                if(!sessionState.isFetching) {
                    vm.takeHome = takeHome
                }
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
