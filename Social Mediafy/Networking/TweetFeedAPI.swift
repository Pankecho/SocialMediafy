//
//  TweetAPI.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

enum TweetAPIError: Error {
    case noData
    case response
    case parsingData
}

protocol TweetAPIProtocol {
    func load(completion: @escaping (Result<[Tweet], Error>) -> ())
}

struct TweetAPI: TweetAPIProtocol {
    let session: URLSession

    func load(completion: @escaping (Result<[Tweet], Error>) -> ()) {
        let request = Endpoint.timeline.request
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
                let timeline = try JSONDecoder().decode([Tweet].self, from: data)
                completion(.success(timeline))
                
            } catch {
                completion(.failure(TweetAPIError.parsingData))
            }
            
        }.resume()
    }
}
