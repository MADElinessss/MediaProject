//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by Madeline on 2/1/24.
//

import Alamofire
import Foundation

enum TMDBAPI {
    case trending
    case rating
    case popular
    case tvSeries(id: Int)
    case cast(id: Int)
    case recommendation(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/tv/week")!
        case .rating:
            return URL(string: baseURL + "movie/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .cast(let id):
            return URL(string: baseURL + "tv/\(id)/aggregate_credits")!
        case .tvSeries(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .recommendation(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization" : APIKey.TMDBaccessToken]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["language":"ko-KR"]
        case .rating:
            ["language":"ko-KR"]
        case .popular:
            ["language":"ko-KR"]
        case .tvSeries:
            ["language":"ko-KR"]
        case .cast:
            ["":""]
        case .recommendation:
            ["language":"ko-KR"]
        }
    }
}
