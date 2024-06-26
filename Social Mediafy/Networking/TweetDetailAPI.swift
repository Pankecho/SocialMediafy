//
//  TweetDetailAPI.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

protocol TweetDetailAPIProtocol {
    func getTweet(id: String, completion: @escaping (Result<TweetDetail, Error>) -> ())
}

struct TweetDetailAPI: TweetDetailAPIProtocol {
    let session: URLSession
    
    func getTweet(id: String, completion: @escaping (Result<TweetDetail, any Error>) -> ()) {
        let request = Endpoint.getTweet(id: id).request
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(TweetAPIError.noData))
                return
            }
            
            do {
                let tweet = try JSONDecoder().decode(TweetDetail.self, from: data)
                completion(.success(tweet))
                
            } catch {
                completion(.failure(TweetAPIError.parsingData))
            }
            
        }.resume()
    }
}
