//
//  NetworkManager.swift
//  SimpleNetwork
//
//  Created by Evgen on 27/10/2022.
//  Copyright © 2022 Evgen. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()
    
    func getUsers(completion: @escaping (ApiResult) -> Void ) {
        
        guard let uri = url else {return }
        
        
        urlSession.dataTask(with: uri) {[weak self] (data, response, error) in
            var result: ApiResult

            //result = .success(users: [User]())
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            
            if error != nil {
                result = .failure(error: error!)
                return
            }
            
            guard let content = data else {
                result = .success(users: [User]())
                return
            }
            
            guard let users = try?self?.decoder.decode([User].self, from: content) else {
                result = .success(users: [User]())
                return
            }
            result = .success(users: users)
            return
            
        }.resume()
    }
}

enum ApiResult {
    case success (users: [User])
    case failure (error: Error)
}
