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
        case 4:
            return "success"
        default:
            return ""
        }
    }
    
    @ViewBuilder
    private func NavAction(icon: String, color: Color, onClick: @escaping () -> Void) -> some View {
        Button {
            onClick()
        } label: {
            Image(systemName: icon)
                .font(.headline)
                .bold()
                .foregroundColor(color)
        }
    }
    
    @ViewBuilder
    private var nextButton: some View {
        if vm.step < 3 {
            NavAction(icon: "chevron.right", color: vm.isNextDisabled ? Color.theme.white30 : Color.theme.accent) {
                vm.nextStep()
            }
        } else if vm.step == 3 {
            Button {
                Task {
                    vm.step += 1
//                        await vm.generateBill()
                }
            } label: {
                Image("send")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 17, height: 7)
                    .foregroundColor(vm.isNextDisabled ? Color.theme.white30 : Color.theme.accent)
            }
        } else if vm.step == 4 {
            Button {
                Task {
                    vm.clearForm()
                }
            } label: {
                Image("restart")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 17, height: 7)
                    .foregroundColor(vm.isNextDisabled ? Color.theme.white30 : Color.theme.accent)
            }
        }
    }
    
    private var navbar: some View {
        HStack {
            if vm.step > 0 && vm.step != 4 {
                NavAction(icon: "chevron.left", color: Color.theme.gray600) {
                    vm.prevStep()
                }
            }
            Spacer()
            SectionTitleView(title: navTitle)
            Spacer()
            nextButton
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
            ScreenView(content: BasicInfoView(vm: vm), index: 0)
            ScreenView(content: AddFriendsView(vm: vm), index: 1)
            ScreenView(content: AddBillItemsView(vm: vm), index: 2)
            ScreenView(content: GenerateBillView(vm: vm), index: 3)
            ScreenView(content: SuccessView(vm: vm), index: 4)
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
