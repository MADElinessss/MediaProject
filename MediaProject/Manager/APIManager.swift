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
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping ((T) -> Void)) {
        AF.request(api.endPoint, 
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(T.self, failure)
            }
        }
    }
}
