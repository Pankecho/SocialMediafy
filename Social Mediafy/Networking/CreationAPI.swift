//
//  CreationAPI.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import Foundation

protocol CreationAPIProtocol {
    func send(id: String, text: String, completion: @escaping (Result<Void, Error>) -> ())
}

struct PostCreationAPI: CreationAPIProtocol {
    let session: URLSession
    
    func send(id: String, text: String, completion: @escaping (Result<Void, any Error>) -> ()) {
        let request = Endpoint.postTweet(text: text).request
        
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
}

struct CommentCreationAPI: CreationAPIProtocol {
    let session: URLSession
    
    func send(id: String, text: String, completion: @escaping (Result<Void, any Error>) -> ()) {
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
