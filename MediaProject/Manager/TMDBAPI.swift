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
            return URL(string: baseURL + "trending/tv/week?language=ko-KR")!
        case .rating:
            return URL(string: baseURL + "tv/top_rated?language=ko-KR")!
        case .popular:
            return URL(string: baseURL + "tv/popular?language=ko-KR")!
        case .cast(let id):
            return URL(string: baseURL + "tv/\(id)/aggregate_credits?language=ko-KR")!
        case .tvSeries(let id):
            return URL(string: baseURL + "tv/\(id)?language=ko-KR")!
        case .recommendation(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations?language=ko-KR")!
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
