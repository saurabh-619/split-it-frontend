//
//  ReceiveMoneyView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 02/10/22.
//

import SwiftUI

struct ReceiveMoneyView: View {
    var body: some View {
        NavigationStack {
            Text("ReceiveMoneyView")
        }
        .tint(Color.red)
    }
}

struct ReceiveMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveMoneyView()
            .preferredColorScheme(.dark)
    }
}
