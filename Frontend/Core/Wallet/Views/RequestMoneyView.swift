//
//  RequestMoneyView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 10/10/22.
//

import SwiftUI

struct RequestMoneyView: View {
    @StateObject private var vm = RequestMoneyViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    heading
                    if vm.isLoading {
                        AccentSpinner()
                            .frame(maxWidth: .infinity)
                            .frame(height: 450, alignment: .center)
                    } else {
                        formFields
                        chooseFriend
                        Spacer()
                            .frame(height: 80)
                        submitButton
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(20)
                .backgroundColor()
                .navigationBarBackButtonHidden()
                .toastView(toast: $vm.toast)
                .task {
                    await vm.getFriends()
                }
            }
        }
    }
}

struct SendMoneyRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestMoneyView()
            .preferredColorScheme(.dark)
    }
}


extension RequestMoneyView {
    private var heading: some View {
        NavbarView(title: "money request")
            .padding(.bottom, 45)
    }
    
    private var formFields: some View {
        VStack(spacing: 24) {
            TextFieldView(placeholder: "your title", text: $vm.title, errorMsg: vm.titleError)
            TextFieldView(placeholder: "your description", text: $vm.description, errorMsg: vm.descriptionError)
            TextFieldView(placeholder: "amount (₹)", text: $vm.amount, isNumber: true, errorMsg: vm.amountError)
        }
        .padding(.bottom, 32)
        
    }
    
    private var chooseFriend: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionTitleView(title: "choose a friend")
            friends
        }
    }
    
    private struct friendUI: View {
        let friend: User
        let hasBorder: Bool
        let onClick: () -> Void
        
        var body: some View {
            Button {
                withAnimation(.spring()) {
                    onClick()
                }
            } label: {
                VStack(spacing: 0) {
                    AvatarView(url: friend.avatar, hasBorder: hasBorder, size: 55.0)
                    Text(friend.username)
                        .font(.subheadline)
                        .foregroundColor(Color.theme.gray400)
                }
            }
        }
    }
    
    private var friends: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(vm.friends) { friend in
                    friendUI(friend: friend, hasBorder: vm.requestee == friend) {
                        vm.selectFriend(friend: friend)
                    }
                }
            }
        }
    }
    
    private var submitButton: some View {
        ActionButtonView(text: "send", isLoading: vm.isSubmitting) {
            Task {
                await vm.sendMoneyRequest(onSubmit: {
                    dismiss()
                })
            }
        }
    }
}
