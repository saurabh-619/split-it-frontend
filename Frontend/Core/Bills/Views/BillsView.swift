//
//  BillsView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 24/09/22.
//

import SwiftUI

struct BillsView: View {
    @StateObject private var vm = BillViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    heading
                    filterSection
                    billsContent
                }
                .padding(20)
            }
            .backgroundColor()
            .toastView(toast: $vm.toast)
            .task {
                await vm.getBills()
            }
            .onChange(of: vm.isLeaderTab) { _ in
                Task {
                    await vm.getBills()
                }
            }
        }
    }
}

struct BillsView_Previews: PreviewProvider {
    static var previews: some View {
        BillsView()
            .preferredColorScheme(.dark)
    }
}

extension BillsView {
    private var heading: some View {
        Text("bills list")
            .font(.title2)
            .bold()
            .padding(.bottom, 16)
    }
    
    private var filterSection: some View {
        HStack {
            Button {
                withAnimation(.spring()) {
                    vm.isLeaderTab = true
                }
            } label: {
                PillView(text: "leader", color: vm.isLeaderTab ? Color.theme.appWhite : Color.theme.white45, bgColor: vm.isLeaderTab ? Color.theme.accent : Color.clear)
            }
            Button {
                withAnimation(.spring()) {
                    vm.isLeaderTab = false
                }
            } label: {
                PillView(text: "split", color: vm.isLeaderTab ? Color.theme.white45 : Color.theme.appWhite, bgColor: vm.isLeaderTab ? Color.clear : Color.theme.accent)
            }
            Spacer()
        }
        .padding(.bottom, 36)
    }
    
    private var bills: some View {
        LazyVStack(spacing: 50) {
            ForEach(vm.bills) { bill in
                BillRowView(isLeader: vm.isLeaderTab, bill: bill)
            }
        }
    }
    
    private var billsContent: some View {
        Group {
            if vm.isLoading {
                AccentSpinner()
                    .frame(height: 450)
            } else {
                if vm.bills.isEmpty {
                    Text("no \(vm.isLeaderTab ? "leader" : "split") bills generated yet")
                        .font(.footnote)
                        .foregroundColor(Color.theme.white60)
                        .frame(height: 150, alignment: .center)
                        .frame(maxWidth: .infinity)
                } else {
                    bills
                }
            }
        }
    }
}
