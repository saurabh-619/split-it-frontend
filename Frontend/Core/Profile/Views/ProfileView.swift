//
//  ProfileView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm: ProfileViewModel
    @State private var showEdit = false
    
    var body: some View {
        VStack {
            navbar
            Spacer()
            if vm.isFetching {
                AccentSpinner()
            } else {
                userDetails
            }
            Spacer()
        }
        .backgroundColor()
        .padding(20)
        .onAppear {
            Task {
                await vm.getCurrentUser()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel())
            .preferredColorScheme(.dark)
    }
}

extension ProfileView {
    var navbar: some View {
        HStack {
            Text("splitit")
                .foregroundColor(Color.theme.white80)
                .font(.title)
                .bold()
            Spacer()
            Button {
                showEdit = true
            } label: {
                Image("edit")
                    .resizable()
                    .foregroundColor(Color.theme.appWhite)
                    .frame(width: 18, height: 18)
            }
            .sheet(isPresented: $showEdit) {
                EditProfileView(user: vm.user) {
                    // on edit complete
                    Task {
                        await vm.getCurrentUser()
                    }
                }
                .presentationDetents([.large])
            }
        }
    }
    
    var avatar: some View {
        CacheImage(url: vm.user.avatar) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80, alignment: .center)
                .clipShape(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                )
        }
        .padding(8)
        .backgroundColor()
        .clipShape(
            RoundedRectangle(cornerRadius: 35, style: .continuous)
        )
        .padding(8)
        .background(
            LinearGradient(colors: [Color.theme.accent, Color.theme.accent.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 45, style: .continuous)
        )
        .padding(.bottom, 5)
    }
    
    var name: some View {
        HStack(spacing: 8) {
            Text("\(vm.user.firstName) \(vm.user.lastName)")
                .font(.title2)
                .bold()
                .padding(.bottom, 0.2)
            
            Image("verified")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.theme.appWhite)
        }
    }
    
    var username: some View {
        Text("@\(vm.user.username)")
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color.theme.white30)
    }
    
    var userDetails: some View {
        Group {
            avatar
            name
            username
            Spacer()
            ActionButtonView(text: "logout") {
                vm.logout()
            }
        }
    }
}
