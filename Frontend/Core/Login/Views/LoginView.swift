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
        VStack(spacing: 20) {
            TextField("username", text: $vm.username)
            TextField("password", text: $vm.password)
            
            Button("Submit") {
                Task {
                    await vm.login(loginRequest: LoginRequest(username: vm.username, password: vm.password))
                }
            }
            
            Button("get token") {
                toast = Toast(title: "congratulations!", message: "you have successfully logged in",duration: 3)
                vm.printToken()
            }
        }
        .padding(20)
        .toastView(toast: $toast)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
