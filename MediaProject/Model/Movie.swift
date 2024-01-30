////
////  MovieModel.swift
////  MediaProject
////
////  Created by Madeline on 1/30/24.
////
//
//import Foundation
//
//// MARK: - Movie
//struct Movie: Codable {
//    let cast, crew: [Cast]
//    let id: Int
//}
//
//// MARK: - Cast
//struct Cast: Codable {
//    let adult: Bool
//    let backdropPath: String?
//    let genreIDS: [Int]
//    let id: Int
//    let originalLanguage: String?
//    let originalTitle, overview: String?
//    let popularity: Double
//    let posterPath: String?
//    let releaseDate, title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//    let character: String?
//    let creditID: String
//    let order: Int?
//    let department: String?
//    let job: String?
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//        case character
//        case creditID = "credit_id"
//        case order, department, job
//    }
//}
