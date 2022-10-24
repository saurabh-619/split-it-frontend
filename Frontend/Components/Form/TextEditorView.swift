//
//  TextEditorView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/10/22.
//

import SwiftUI

struct TextEditorView: View {
    var placeholder = ""
    let splitString: Binding<String>
    
    var body: some View {
        TextEditor(text: splitString)
            .multilineTextAlignment(.trailing)
            .autocorrectionDisabled()
            .frame(width: 120)
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(placeholder: "write something", splitString: .constant(""))
        .preferredColorScheme(.dark)
    }
}
