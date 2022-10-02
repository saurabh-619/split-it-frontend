//
//  EmptyListTitle.swift
//  Frontend
//
//  Created by Saurabh Bomble on 26/09/22.
//

import SwiftUI

struct PeopleListView: View {
    let emptyText: String
    let people: [User]
    
    @State private var selectedUserId: Int?
    
    var body: some View {
        if people.isEmpty {
            Text(emptyText)
                .font(.footnote)
                .foregroundColor(Color.theme.white60)
                .frame(height: 120, alignment: .center)
                .frame(maxWidth: .infinity)
        } else {
            LazyVStack(spacing: 24) {
                ForEach(people, id: \.id) { person in
                    PersonRowView(user: person)
                        .onTapGesture {
                            selectedUserId = person.id
                        }
                        .sheet(isPresented: Binding<Bool>(
                            get: {
                                self.selectedUserId == person.id
                            }, set: { _ in
                                // on binding = false (on dismiss)
                                self.selectedUserId = nil
                            }
                        )) {
                            UserView(id: selectedUserId!)
                        }
                }
            }
        }
    }
}

struct EmptyListTitle_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(emptyText: "you don't any friends yet.", people:[])
            .preferredColorScheme(.dark)
    }
}
