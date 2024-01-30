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
    
    func fetchTrendingTV(completionHandler: @escaping (([TV]) -> Void)) {
        let url = "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR"
        let header: HTTPHeaders = [
            "accept": "application/json",
            "Authorization" : APIKey.TMDBaccessToken
        ]
        
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
        let url = "https://api.themoviedb.org/3/movie/top_rated?language=ko-KR"
        let header: HTTPHeaders = ["Authorization" : APIKey.TMDBaccessToken]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: RatingTV.self) { response in
            switch response.result {
            case .success(let success):
//                print(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    
    func fetchPopularTV(completionHandler: @escaping ((PopularTV) -> Void)) {
        let url = "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
        let header: HTTPHeaders = ["Authorization" : APIKey.TMDBaccessToken]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: PopularTV.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
