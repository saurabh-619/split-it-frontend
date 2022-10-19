//
//  PendingFriendRequestsView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 01/10/22.
//

import SwiftUI

struct PendingFriendRequestsView: View {
    @StateObject private var vm = PendingFriendRequestsViewModel()

    @State private var selectedUserId: Int?
    
    var body: some View {
        NavigationStack {
            VStack {
                heading
                if vm.isLoading {
                    AccentSpinner()
                        .frame(height: 450)
                } else {
                    content
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .toastView(toast: $vm.toast)
            .task {
                await vm.getPendingFriendRequests()
        }
        }
    }
}

struct PendingFriendRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PendingFriendRequestsView()
            .preferredColorScheme(.dark)
    }
}

extension PendingFriendRequestsView {
    private var heading: some View {
        SheetHeadingView(title: "friend requests").padding(.bottom, 16)
    }
    
    private var friendRequests: some View {
        LazyVStack(spacing: 24) {
            ForEach(vm.friendRequests.indices, id: \.self) { index in
                let request = vm.friendRequests[index]
                PersonRowView(user: request.requester, hasButton: true, buttonText: vm.buttonText[index], buttonTextColor: vm.buttonTextColor[index], isButtonDisabled: vm.isButtonDisabled[index]) {
                    Task {
                        await vm.onAcceptClicked(requestId: request.id, index: index)
                    }
                }
                .onTapGesture {
                    self.selectedUserId = request.id
                }
                .sheet(isPresented: Binding<Bool>(
                    get: {
                        request.id == self.selectedUserId
                    }, set: { _ in
                        // on binding = false (on dismiss)
                        self.selectedUserId = nil
                    }
                )) {
                    UserView(id: self.selectedUserId!)
                }
            }
        }
    }
    
    private var content: some View {
        Group {
            if vm.friendRequests.isEmpty {
                Text("no pending friend requests")
                    .font(.caption2)
                    .foregroundColor(Color.theme.white60)
                    .frame(height: 120, alignment: .center)
                    .frame(maxWidth: .infinity)
            } else {
                friendRequests
            }
        }
    }
}
