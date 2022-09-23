//
//  EditProfile.swift
//  Frontend
//
//  Created by Saurabh Bomble on 23/09/22.
//

import SwiftUI

struct EditProfileView: View {
    let user: User
    let onEditComplete: () -> Void
    
    @StateObject private var vm: EditProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User, onEditComplete: @escaping () -> Void) {
        self.user = user
        self._vm = StateObject(wrappedValue: EditProfileViewModel(user: user))
        self.onEditComplete = onEditComplete
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    heading
                    Spacer()
                        .frame(height: 45)
                    registerFields
                    Spacer()
                        .frame(height: 180)
                    footer
                }
                .padding(20)
                .backgroundColor()
            }
            .toastView(toast: $vm.toast)
            .navigationBarBackButtonHidden()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: self.dev.user, onEditComplete: {
            print("onEditComplete")
        })
        .preferredColorScheme(.dark)
    }
}


extension EditProfileView {
    private var heading: some View {
        Group {
            HStack {
                Text("edit")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(Color.theme.white45)
                    .padding(.bottom, 1)
                Spacer()
                closeButton
            }
            
            Text("hi, \("saurabh")")
                .font(.system(size: 40, weight: .bold))
        }
    }
    
    private var closeButton: some View {
        Button {
            self.dismiss()
        } label: {
            Image("close")
                .resizable()
                .foregroundColor(Color.theme.appWhite)
                .frame(width: 18, height: 18)
        }
    }
    
    private var registerFields: some View {
        VStack(spacing: 24) {
            TextFieldView(placeholder: vm.firstName, text: $vm.firstName, errorMsg: vm.firstNameError)
            TextFieldView(placeholder: vm.lastName, text: $vm.lastName, errorMsg: vm.lastNameError)
            TextFieldView(placeholder: vm.email, text: $vm.email, isEmail: true, errorMsg: vm.emailError)
            TextFieldView(placeholder: vm.username, text: $vm.username, haveSpinner: vm.isUsernameSearching, errorMsg: vm.usernameError)
        }
    }
    
    private var editButton: some View {
        ActionButtonView(text: "edit", isLoading: vm.isLoading) {
            Task {
                await vm.edit(dismiss: {
                    self.dismiss()
                })
                onEditComplete()
            }
        }
    }
    
    private var footer: some View {
        VStack {
            editButton
        }
    }
}
