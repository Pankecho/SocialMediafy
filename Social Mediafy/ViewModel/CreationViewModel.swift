//
//  CreationViewModel.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import Foundation

protocol CreationViewModelProtocol {
    var navTitle: String { get }
    var title: String { get }
    
    var state: Observer<ViewModelState> { get set }
    
    init(id: String, provider: CreationAPIProtocol)
    
    func sendData(text: String)
}

final class TweetCreationViewModel: CreationViewModelProtocol {
    private let provider: CreationAPIProtocol
    
    var navTitle: String {
        return "Create tweet"
    }
    
    var title: String {
        return "What's on your mind?"
    }
    
    var state: Observer<ViewModelState> = Observer<ViewModelState>()
    
    init(id: String, provider: any CreationAPIProtocol) {
        self.provider = provider
    }
    
    func sendData(text: String) {
        state.value = .loading
        
        provider.send(id: "", text: text) { result in
            switch result {
            case .success(let tweet):
                self.state.value = .success
            case .failure(_):
                self.state.value = .failure
            }
        }
    }
}

final class CommentCreationViewModel: CreationViewModelProtocol {
    private let provider: CreationAPIProtocol
    
    private let id: String
    
    var navTitle: String {
        return "Replying to"
    }
    
    var title: String {
        return "What's on your mind?"
    }
    
    var state: Observer<ViewModelState> = Observer<ViewModelState>()
    
    init(id: String, provider: any CreationAPIProtocol) {
        self.id = id
        self.provider = provider
    }
    
    func sendData(text: String) {
        state.value = .loading
        
        provider.send(id: id, text: text) { result in
            switch result {
            case .success(let tweet):
                self.state.value = .success
            case .failure(_):
                self.state.value = .failure
            }
        }
    }
}

