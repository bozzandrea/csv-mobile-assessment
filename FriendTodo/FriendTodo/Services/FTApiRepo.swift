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
    
    /**
      Get friends list 

      - Parameters:
    
      */
    func getFriends(completion: @escaping ([Friend]?, Error?) -> Void){
        let apiUrl = apiBaseURL.appendingPathComponent(usersEp)
        session.dataTask(with: apiUrl) { (data, response, error) in
          guard let data = data else { return }
          let movies = try! JSONDecoder().decode([Friend].self, from: data)
          completion(movies, nil)
        }.resume()

    }
}


