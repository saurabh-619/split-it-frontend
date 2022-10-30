//
//  BasicInfoView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/10/22.
//

import SwiftUI

struct BasicInfoView: View {
    @ObservedObject var vm: AddViewModel
    
    var body: some View {
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
}

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView(vm: AddViewModel())
            .preferredColorScheme(.dark)
    }
}
