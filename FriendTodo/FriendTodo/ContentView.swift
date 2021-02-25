//
//  ContentView.swift
//  FriendTodo
//
//  Created by Andrea Bozza on 23/02/2021.
//

import SwiftUI
import SwiftUIRefresh

struct FriendView: View {
    let friend: Friend
    var body: some View {
        Text("Selected friend: \(friend.name)")
            .font(.largeTitle)
    }
}

struct ContentView: View {
    @State var friends: [Friend] = []
    @State private var isShowing = false
    
    let apiRespository = FTApiRepo()
    
    var body: some View {
        NavigationView {
            List(friends) { friend in
                NavigationLink(destination: FriendView(friend: friend)) {
                    Text(friend.name)
                }
            }
            .navigationTitle("Welcome")
            .toolbar {
                Button("About") {
                    print("About tapped!")
                }
            }
        }.pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                apiRespository.getFriends { (friends, error) in
                    self.friends = friends ?? []
                    self.isShowing = false
                }
            }
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
