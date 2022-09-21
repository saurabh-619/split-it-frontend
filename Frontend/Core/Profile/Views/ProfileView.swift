//
//  ProfileView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 21/09/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            HStack {
                Text("splitit")
                    .foregroundColor(Color.theme.white80)
                    .font(.title)
                    .bold()
                Spacer()
            }
            Spacer(minLength: 200)
            AsyncImage(url: <#T##URL?#>)
        }
        .backgroundColor()
        .padding(20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
