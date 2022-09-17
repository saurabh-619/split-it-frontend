//
//  HomeView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 18/09/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home View")
            .navigationBarBackButtonHidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
