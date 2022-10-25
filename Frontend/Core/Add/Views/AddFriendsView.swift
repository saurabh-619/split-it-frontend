//
//  AddFriendsView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/10/22.
//

import SwiftUI

struct AddFriendsView: View {
    @EnvironmentObject private var sessionState: SessionState
    @ObservedObject var vm: AddViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                if(!vm.friends.isEmpty) {
                    selectedFriendsTitle
                    selectedFriends
                        .padding(.bottom, 16)
                    SectionTitleView(title: "contact list")
                }
                friendsList
            }
        }
    }
}

struct AddFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsView(vm: AddViewModel())
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension AddFriendsView {
    private var selectedFriendsTitle: some View {
        HStack {
            SectionTitleView(title: "selected \(vm.selectedFriends.filter{$0.id != sessionState.user.id}.count)/\(vm.friends.count)")
            Spacer()
            Button {
                vm.clearSelectedFriends()
            } label: {
                Text("clear")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.white60)
            }
        }
    }
    
    private var selectedFriends: some View {
        Group {
            if vm.selectedFriends.isEmpty {
                Text("add one or more friends")
                    .font(.caption)
                    .foregroundColor(Color.theme.gray500)
                    .frame(maxWidth: .infinity)
            } else {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .center,spacing: 24) {
                            ForEach(vm.selectedFriends.filter{$0.id != sessionState.user.id}) { friend in
                                VStack(spacing: 8) {
                                    CacheImageView(url: friend.avatar) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                            )
                                    }
                                    Text(friend.username)
                                        .font(.footnote)
                                        .foregroundColor(Color.theme.white60)
                                        .id(friend.id)
                                }
                                .onChange(of: vm.selectedFriends) { selectedFriends in
                                    withAnimation(.spring()) {
                                        proxy.scrollTo(selectedFriends.last?.id ?? 0, anchor: .leading)
                                    }
                                }
                            }
                        }
                    }
                    .animation(.easeIn(duration: 0.2), value: vm.selectedFriends.count)
                }
            }
        }
        .frame(height: 85)
    }
    
    @ViewBuilder
    private var friendsList: some View {
        if vm.friends.isEmpty {
            Text("you don't any friends yet. we can't move forward without friends")
                .font(.footnote)
                .foregroundColor(Color.theme.white60)
                .multilineTextAlignment(.center)
                .frame(height: 40, alignment: .center)
                .frame(maxWidth: .infinity)
        } else {
            LazyVStack(spacing: 24) {
                ForEach(vm.friends, id: \.id) { friend in
                    PersonRowView(user: friend, hasButton: true, buttonText: vm.selectedFriends.contains(friend) ? "remove" : "add", buttonTextColor: vm.selectedFriends.contains(friend) ? Color.theme.gray500 : Color.theme.accent) {
                        vm.addOrRemoveSelectedFriend(friend: friend)
                    }
                }
            }
        }
    }
}
