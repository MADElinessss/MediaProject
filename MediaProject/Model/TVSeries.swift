//
//  TVSeries.swift
//  MediaProject
//
//  Created by Madeline on 1/31/24.
//

import Foundation

struct TVSeries: Codable {
    let backdropPath: String?
    let episodeRunTime: [Int]
    let id: Int
    let name: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case id
        case name
        case posterPath = "poster_path"
    }
}
