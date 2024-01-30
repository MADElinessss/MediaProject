//
//  RatingTV.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import Foundation

struct RatingTV: Decodable {
    let results: [RatingTVResults]
}

struct RatingTVResults: Decodable {
//    let backdropPath: String
//    let id: Int
//    let overview: String
    let posterPath: String
//    let title: String
    
    enum CodingKeys: String, CodingKey {
//        case backdropPath = "backdrop_path"
//        case id
//        case overview
        case posterPath = "poster_path"
//        case title
    }
}
