//
//  Recommendation.swift
//  MediaProject
//
//  Created by Madeline on 2/1/24.
//

import Foundation

struct Recommendation: Decodable {
    let results: [RecommendationResult]
}

// MARK: - Result
struct RecommendationResult: Decodable {
    let backdropPath: String
    let id: Int
    let name, overview: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case overview
        case posterPath = "poster_path"
    }
}
