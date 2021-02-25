//
//  ContentView.swift
//  FriendTodo
//
//  Created by Andrea Bozza on 23/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State var friends: [Friend] = []
    let apiRespository = FTApiRepo()
    var body: some View {
        List(friends) { friend in
            
            Text(friend.username)
                .font(.headline)
            Text(friend.name)
                .font(.subheadline)
            
        }
        .onAppear {
            apiRespository.getFriends { (friends, error) in
                self.friends = friends ?? []
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
