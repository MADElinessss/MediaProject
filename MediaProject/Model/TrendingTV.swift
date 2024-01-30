//
//  TrendingMovies.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import Foundation

struct TrendingTV: Decodable {
    
    let page: Int
    let results: [TV]
    
}

struct TV: Decodable {
    let id: Int
    let name: String
    let originalName: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
