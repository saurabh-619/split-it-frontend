//
//  SuccessView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/10/22.
//

import SwiftUI

struct SuccessView: View {
    @ObservedObject var vm: AddViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                ZStack {
                    LottieView(animationName: "confetti", loopMode: .loop)
                        .frame(height: 330)
                        .frame(maxWidth: .infinity)
                    LottieView(animationName: "success")
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Group {
                Text("split bill success")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.theme.gray400)
                    .padding(.bottom, 8)
                
                Text("\(vm.total) INR")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(Color.theme.accent)
                
                TransactionDividerView(isDashed: true)
                    .padding(.vertical, 24)
                
                Text("split bills sent to \(vm.selectedFriends.count) people")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color.theme.gray500)
                    .padding(.bottom, 24)
                
                if(!vm.selectedFriends.isEmpty) {
                    AvatarRowView(people: vm.selectedFriends, size: 35)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 20)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(vm: AddViewModel())
            .preferredColorScheme(.dark)
    }
}
