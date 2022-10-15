//
//  ProgressView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 15/10/22.
//

import SwiftUI

struct BillProgressView: View {
    let fractionPaid: String
    var size: Double = 75.0
    var lineWidth: Double = 6.0
    var fontSize1: Double = 16.0
    var fontSize2: Double = 12.0
    
    
    private var progressColor: Color {
        switch Double(fractionPaid) ?? 0.0 {
        case 0.0...0.25:
            return Color.theme.danger
        case 0.25...0.75:
            return Color.theme.warning
        case 0.75...1.0:
            return Color.theme.success
        default:
            return Color.theme.success
        }
    }
    
    var body: some View {
        ZStack {
            progressCircle
            VStack {
                Text("\((Double(fractionPaid)! * 100).getZeroDigitString)%")
                    .font(.system(size: fontSize1))
                    .fontWeight(.heavy)
                    .foregroundColor(progressColor)
                
                Text("paid")
                    .font(.system(size: fontSize2))
                    .bold()
                    .foregroundColor(Color.theme.white80)
            }
        }
    }
}

struct BillProgressView_Previews: PreviewProvider {
    static var previews: some View {
        BillProgressView(fractionPaid: "0.3")
            .preferredColorScheme(.dark)
    }
}

extension BillProgressView {
    private var progressCircle: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.theme.gray700,
                    lineWidth: lineWidth
                )
                .frame(width: size, height: size)
            Circle()
                .trim(from: 0, to: Double(fractionPaid) ?? 0.0)
                .stroke(
                    progressColor,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(), value: fractionPaid)
                .frame(width: size, height: size)
        }
    }
}
