//
//  HomeView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var sessionState: SessionState
    
    var body: some View {
        VStack{
            Text(sessionState.user.firstName)
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

