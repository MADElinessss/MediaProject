//
//  APIManager.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import Alamofire
import Foundation

class APIManager {
    // 싱글톤 인스턴스!
    static let shared = APIManager()
    
    let header: HTTPHeaders = [
        "accept": "application/json",
        "Authorization" : APIKey.TMDBaccessToken
    ]
    
    let baseURL = "https://api.themoviedb.org/3/"
    
    func fetchTrendingTV(completionHandler: @escaping (([TV]) -> Void)) {
        let url = baseURL + "trending/tv/week?language=ko-KR"
    
        AF.request(url, method: .get, headers: header).responseDecodable(of: TrendingTV.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    
    func fetchTopRatedTV(completionHandler: @escaping ((RatingTV) -> Void)) {
        let url = baseURL + "movie/top_rated?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: RatingTV.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    
    func fetchPopularTV(completionHandler: @escaping ((PopularTV) -> Void)) {
        let url = baseURL + "tv/popular?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: PopularTV.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTVSeries(_ id: Int, completionHandler: @escaping ((TVSeries) -> Void)) {
        
        let url = baseURL + "tv/\(id)?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: TVSeries.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchRecommendation(_ id: Int, completionHandler: @escaping ((Recommendation) -> Void)) {
        let url = baseURL + "tv/\(id)/recommendations?language=ko-KR"
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Recommendation.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchCast(_ id: Int, completionHandler: @escaping ((Cast) -> Void)) {
        let url = baseURL + "tv/\(id)/aggregate_credits"
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Cast.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
