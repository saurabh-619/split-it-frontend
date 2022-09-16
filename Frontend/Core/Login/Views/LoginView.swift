//
//  LoginView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 14/09/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject() private var vm = LoginViewModel()
    @State private var toast: Toast?
    
    
    var body: some View {
        ZStack {
            Color
                .theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("let's sign you in.")
                Text("welcome back.")
                Text("you've been missed")
                
                Spacer(minLength: 20)
                
                TextField("username", text: $vm.username)
                PasswordFieldView(title: "password", password: $vm.password, isPasswordVisible: $vm.isPasswordVisible)
                
                Button("Submit") {
                    Task {
                        await vm.login(loginRequest: LoginRequest(username: vm.username, password: vm.password))
                    }
                }
                
                Button("get token") {
                    toast = Toast(type: .success, title: "congratulations!", message: "you have successfully logged in", duration: 3)
                    vm.printToken()
                }
            }
            .padding(20)
        }
        .backgroundColor()
        .toastView(toast: $toast)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
