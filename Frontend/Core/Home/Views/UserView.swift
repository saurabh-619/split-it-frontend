//
//  UserView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 26/09/22.
//

import SwiftUI

struct UserView: View {
    var id: Int
    @StateObject var vm = UserViewModel()
    @EnvironmentObject var sessionState: SessionState
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                if vm.isLoading {
                    AccentSpinner()
                        .frame(height: 450)
                } else {
                    userInfo
                    if sessionState.user.id != vm.user.id {
                        followButton
                        moneyRequests
                    }
                }
            }
        }
        .padding(20)
        .task {
            await vm.getUser(userId: id)
        }
        .toastView(toast: $vm.toast)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(id: 1)
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension UserView {
    private var userInfo: some View {
        HStack(spacing: 22) {
            AvatarView(url: vm.user.avatar, hasBorder: true)
                .padding(.bottom, -1)
            
            VStack(alignment: .leading) {
                Text("\(vm.user.firstName) \(vm.user.lastName)")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 2)
                
                Group {
                    Text("\(vm.user.username)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.white45)
                    
                    Text("\(vm.user.email)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.white45)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
    
    private var followButton: some View {
        ActionButtonView(text: vm.followBtnText, isDisabled: vm.isDisabled) {
            Task {
                switch vm.followBtnText {
                case "add friend":
                    await vm.addFriend()
                case "unfriend":
                    await vm.unfriendTheFriend()
                default:
                    print("doing nothing")
                }
            }
        }
        .padding(.bottom, 20)
    }
    
    private var requests: some View {
        Group {
            if vm.moneyRequests.isEmpty {
                Text("no money request with @\(vm.user.username)")
                    .font(.caption2)
                    .foregroundColor(Color.theme.white60)
                    .frame(height: 120, alignment: .center)
                    .frame(maxWidth: .infinity)
            } else {
                LazyVStack(spacing: 24) {
                    ForEach(vm.moneyRequests, id: \.id) { moneyRequest in
                        MoneyRequestRowView(moneyRequest: moneyRequest)
                            .padding(.bottom, 8)
                    }
                }
                .ignoresSafeArea(.all)
            }
        }
    }
    
    private var moneyRequests: some View {
        VStack(alignment: .leading) {
            Text("money requests")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.appWhite)
                .padding(.bottom, 16)
                requests
        }
    }
}
