//
//  FTApiRepos.swift
//  FriendTodo
//
//  Created by Andrea Bozza on 23/02/2021.
//

import Foundation
import SwiftUI

class Friend: Codable, Identifiable {
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
        let session = URLSession(configuration: .default)
        session.dataTask(with: apiUrl) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "no data", code: 10, userInfo: nil))
                return
            }
            do {
                let friends = try JSONDecoder().decode([Friend].self, from: data)
                completion(friends, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}


