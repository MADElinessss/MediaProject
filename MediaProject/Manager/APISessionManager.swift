//
//  APISessionManager.swift
//  MediaProject
//
//  Created by Madeline on 2/5/24.
//

import Foundation

enum TMDBError: Error {
    case failedRequest
    case emptyData
    case wrongData
    case invalidResponse
    case invalidData
}

class APISessionManager {
    static let shared = APISessionManager()
    
    private init() { }
    
    func fetchTV<T: Decodable>(type: T.Type, api: TMDBAPI, url: URL, completionHandler: @escaping ((T?, TMDBError?) -> Void)) {

        var fullUrl: URLRequest = URLRequest(url: url)
        fullUrl.addValue(APIKey.TMDBaccessToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: fullUrl) { data, response, error in
            DispatchQueue.main.async() {
                guard error == nil else {
                    completionHandler(nil, .failedRequest)
                    return
                }
                guard let data = data else {
                    completionHandler(nil, .emptyData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result, nil)
//                    print(result)
                } catch {
                    completionHandler(nil, .wrongData)
                }
            }
        }
        .resume()
    }
}
