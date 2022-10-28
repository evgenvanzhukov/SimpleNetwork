//
//  UserModel.swift
//  SimpleNetwork
//
//  Created by Evgen on 27/10/2022.
//  Copyright © 2022 Evgen. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let userId: Int
    let address: Address
    
    enum CodingKeys: String, CodingKey {
        case name
        case userId = "id"
        case address
    }
}


struct Address: Codable {
    let street: String
    let city: String
}
