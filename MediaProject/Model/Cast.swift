//
//  Cast.swift
//  MediaProject
//
//  Created by Madeline on 2/1/24.
//

import Foundation

struct Cast: Decodable {
    let cast, crew: [Actors]
    let id: Int
}

struct Actors: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}
