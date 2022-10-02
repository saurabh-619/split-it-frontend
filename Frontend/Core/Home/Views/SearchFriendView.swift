//
//  SearchFriendView.swift
//  Frontend
//
//  Created by Saurabh Bomble on 25/09/22.
//

import SwiftUI

struct SearchFriendView: View {
    @EnvironmentObject private var sessionState: SessionState
    @StateObject private var vm = SearchFriendViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            heading
            search
            resultTitle
            results
            Spacer()
        }
        .padding(20) 
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFriendView()
            .environmentObject(SessionState())
            .preferredColorScheme(.dark)
    }
}

extension SearchFriendView {
    private var heading: some View {
        SheetHeadingView(title: "friends")
            .padding(.bottom, 16)
    }
    
    private var search: some View {
        TextFieldView(placeholder: "search friends on splitit", text: $vm.query)
            .padding(.bottom, 16)
    }
    
    private var resultTitle: some View {
        Text("results")
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(Color.theme.white60)
            .padding(.bottom, 16)
    }
    
    private var results: some View {
        PeopleListView(emptyText: vm.count == 0 ? "couldn't find user searched" : "", people: vm.results)
    }
}
