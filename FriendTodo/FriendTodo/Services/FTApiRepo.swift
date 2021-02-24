//
//  FTApiRepos.swift
//  FriendTodo
//
//  Created by Andrea Bozza on 23/02/2021.
//

import Foundation

class Friend: Codable {
    let name: String
    let username: String
}

class FTApiRepo {
    var session: URLSession!
    var cachedUrl: URL?
    func getFriends(completion: @escaping ([Friend]?, Error?) -> Void) {
        
    }
}


