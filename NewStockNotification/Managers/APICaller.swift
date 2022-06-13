//
//  APICaller.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    struct Constants {
        static let baseAPIURL = "https://newbal-b477c-default-rtdb.firebaseio.com"
    }
    
    private init() {}
    
    public func getCurrentShoesStock(completion: @escaping (Result<Products, Error>) -> Void) {
        
        let baseRequest = createRequest(with: URL(string: Constants.baseAPIURL + "/" + ".json"), type: .GET)
        let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData) )
                return
            }
            
            do {
//                 let res = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let res = try JSONDecoder().decode(Products.self, from: data)
                completion(.success(res))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    

    private func createRequest(with url: URL?, type: HTTPMethod) -> URLRequest {
        guard let apiURL = url else { fatalError() }
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        
        return request
    }
    
}
