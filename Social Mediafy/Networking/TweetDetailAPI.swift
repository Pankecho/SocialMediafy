//
//  TweetDetailAPI.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

protocol TweetDetailAPIProtocol {
    func comment(id: String, text: String, completion: @escaping (Result<Void, Error>) -> ())
}

struct TweetDetailAPI: TweetDetailAPIProtocol {
    let session: URLSession

    func comment(id: String, text: String, completion: @escaping (Result<Void, any Error>) -> ()) {
        let request = Endpoint.commentTweet(id: id,
                                            comment: text).request
        
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
}
