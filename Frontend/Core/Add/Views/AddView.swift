//
//  AddView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject private var sessionState: SessionState
    @StateObject var vm = AddViewModel()
    
    var body: some View {
        ZStack {
            steps
            navbar
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            vm.addOrRemoveSelectedFriend(friend: sessionState.user)
        }
        .task {
            await vm.getFriends()
        }
        .toastView(toast: $vm.toast)
        .backgroundColor()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension AddView {
    private var navTitle: String {
        switch vm.step {
        case 0:
            return "basic info"
        case 1:
            return "add friends"
        case 2:
            return "add bill items"
        case 3:
            return "generate bill"
        default:
            return ""
        }
    }
    
    private var navbar: some View {
        HStack {
            if vm.step > 0 {
                Button {
                    vm.prevStep()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color.theme.gray600)
                }
            }
            Spacer()
            SectionTitleView(title: navTitle)
            Spacer()
            if vm.step < 3 {
                Button {
                    vm.nextStep()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .bold()
                        .foregroundColor(vm.isNextDisabled ? Color.theme.white30 : Color.theme.accent)
                }
                .disabled(vm.isNextDisabled)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func BasicInfoView() -> some View {
        VStack(spacing: 24) {
            Image("coins-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .padding(.bottom, 32)
            TextFieldView(placeholder: "title", text: $vm.title, errorMsg: vm.titleError)
            TextFieldView(placeholder: "description", text: $vm.description, isMultiline: true, height: 100, errorMsg: vm.descriptionError)
        }
    }
    
    private var selectedFriendsTitle: some View {
        Group {
            if(!vm.friends.isEmpty) {
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
                .frame(height: 120, alignment: .center)
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
    
    @ViewBuilder
    func AddFriendsView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                selectedFriendsTitle
                selectedFriends
                    .padding(.bottom, 16)
                SectionTitleView(title: "contact list")
                friendsList
            }
        }
    }
    
    @ViewBuilder
    func ScreenView<Content: View>(content: Content, index: Int) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 80)
            .offset(x: UIScreen.screenWidth * CGFloat(index - vm.step))
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.9, blendDuration: 0.58), value: vm.step)
    }
    
    private var steps: some View {
        return ZStack {
            ScreenView(content: BasicInfoView(), index: 0)
            ScreenView(content: AddFriendsView(), index: 1)
            ScreenView(content: AddBillItemsView(vm: vm), index: 2)
            ScreenView(content: GenerateBillView(vm: vm), index: 3)
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
