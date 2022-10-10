//
//  HomeView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var sessionState: SessionState
    @StateObject private var vm = HomeViewModel()
    
    @State private var showFriends = false
    @State private var showFriendRequests = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    headline
                    friends
                    Spacer()
                }
                .padding(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .backgroundColor()
            }
            .task {
                await vm.getFriends()
            }
            .refreshable {
                Task {
                    await vm.getFriends()
                }
            }
            .toastView(toast: $vm.toast)
            .navigationBarBackButtonHidden()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension HomeView {
    private var headline: some View {
        HStack {
            Text("hi \(sessionState.user.username)")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.white60)
            
            Spacer()
            
            Button {
                showFriendRequests = true
            } label: {
                Image("bell")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color.theme.appWhite)
            }
        }
        .padding(.bottom, 24)
        .sheet(isPresented: $showFriendRequests) {
            PendingFriendRequestsView()
        }
    }
    
    private var friends: some View {
        Group {
            if vm.isLoading {
                AccentSpinner()
                    .frame(height: 450)
                    .frame(maxWidth: .infinity)
            } else {
                HStack(alignment: .center) {
                    SectionTitleView(title: "near by friends")
                    Spacer()
                    Button {
                        showFriends = true
                    } label: {
                        Text("add")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.white60)
                    }
                }
                .padding(.bottom, 10)
                .sheet(isPresented: $showFriends) {
                    SearchFriendView()
                }
                
                ScrollView {
                    PeopleListView(emptyText: "you don't any friends yet.", people: vm.friends)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

}

