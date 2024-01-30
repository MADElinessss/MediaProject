//
//  PopularTV.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import Foundation

struct PopularTV: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let id: Int
    let originalName: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
    }
}