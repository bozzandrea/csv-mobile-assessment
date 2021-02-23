//
//  FTApiRepos.swift
//  FriendTodo
//
//  Created by Andrea Bozza on 23/02/2021.
//

import Foundation

class FTApiRepo {
    
    class Friend: Codable {
        let name: String
        let username: String
    }
    
    class APIRepository {
        func getFriends(completion: @escaping ([Friend]?, Error?) -> Void) {
            
        }
    }
    
}


