//
//  ValidationErrorView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 17/09/22.
//

import SwiftUI

struct ValidationErrorView: View {
    let errorMsg: String?
    
    var body: some View {
        if let errorMsg = errorMsg {
            Text("* \(errorMsg)")
                .font(.footnote)
                .foregroundColor(Color.theme.danger)
                .fixedSize(horizontal: false, vertical: true)
            
        }
    }
}

struct ValidationErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationErrorView(errorMsg: "error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi error boi ")
    }
}
