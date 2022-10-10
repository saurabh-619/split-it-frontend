//
//  Tabbar.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI

struct Tabbar: View {
    @State var currentScreen: Screen = Screen.HOME
    @EnvironmentObject private var sessionState: SessionState
    
    var body: some View {
        ZStack() {
            switch currentScreen {
            case .HOME:
                HomeView()
            case .WALLET:
                WalletView()
            case .ADD:
                AddView()
            case .BILLS:
                BillsView()
            case .PROFILE:
                ProfileView()
            }
            
            HStack() {
                ForEach(Tab.tabs, id: \.icon) { tab in
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
            .environmentObject(sessionState)
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
            .environmentObject(SessionState())
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
