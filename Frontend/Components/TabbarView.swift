//
//  Tabbar.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI


enum Screen {
    case HOME
    case WALLET
    case ADD
    case PROFILE
}

struct Tab {
    let icon: String
    let title: String
    let screen: Screen
}

let tabs = [
    Tab(icon: "home", title: "home", screen: Screen.HOME),
    Tab(icon: "wallet", title: "wallet", screen: Screen.WALLET),
    Tab(icon: "plus", title: "transaction", screen: Screen.ADD),
    Tab(icon: "user", title: "profile", screen: Screen.PROFILE)
]

struct Tabbar: View {
    @State var currentScreen: Screen = Screen.HOME
    @StateObject var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack() {
            switch currentScreen {
            case .HOME:
                HomeView()
            case .WALLET:
                WalletView()
            case .ADD:
                AddView()
            case .PROFILE:
                ProfileView(vm: profileVM)
            }
            
            HStack() {
                ForEach(tabs, id: \.icon) { tab in
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            currentScreen = tab.screen
                        }
                    } label: {
                        tabComponent(tab: tab)
                    }
                    Spacer()
                }
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .shadow(color: Color.theme.accent.opacity(0.45), radius: 90, x: 0, y: -1)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        .backgroundColor()
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
            .preferredColorScheme(.dark)
    }
}

extension Tabbar {
    private func tabComponent(tab: Tab) -> some View {
        VStack(alignment: .center) {
            if tab.screen == currentScreen {
                Rectangle()
                    .fill(Color.theme.success)
                    .frame(width: 22, height: 4)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                    )
            }
            Spacer()
            Image(tab.icon)
                .resizable()
                .frame(width: 22, height: 22)
            Text(tab.title)
                .font(.system(size: 10))
            Spacer()
        }
        .foregroundColor(tab.screen == currentScreen ? Color.theme.appWhite : Color.theme.gray500)
        .frame(alignment: .center)
    }
}
