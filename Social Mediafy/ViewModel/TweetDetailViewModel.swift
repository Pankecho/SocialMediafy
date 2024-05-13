//
//  TweetDetailViewModel.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

protocol TweetDetailViewModelProtocol {
    var content: String { get }
    var nickName: String { get }
    var userName: String { get }
    var commentCount: Int { get }
    
    var state: Observer<ViewModelState> { get set }
    
    init(id: String, provider: TweetDetailAPIProtocol)
    func getTweet()
    func getComment(at index: Int) -> TweetCommentViewModelProtocol
}

final class TweetDetailViewModel: TweetDetailViewModelProtocol {
    private let provider: TweetDetailAPIProtocol
    
    private var item: TweetDetail = .empty
    
    var state: Observer<ViewModelState> = Observer<ViewModelState>()
    
    var content: String {
        return item.text
    }
    
    var nickName: String {
        return item.user.nickname
    }
    
    var userName: String {
        return item.user.name
    }
    
    var commentCount: Int {
        return item.comments.count
    }
    
    init(id: String, provider: TweetDetailAPIProtocol) {
        self.provider = provider
        self.item = .init(id: id, text: "",
                          user: .init(id: "",
                                      name: "",
                                      nickname: ""),
                          comments: [])
    }
    
    func getTweet() {
        state.value = .loading
        
        provider.getTweet(id: item.id) { result in
            switch result {
            case .success(let tweet):
                self.item = tweet
                self.state.value = .success
            case .failure(_):
                self.state.value = .failure
            }
        }
    }
    
    func getComment(at index: Int) -> any TweetCommentViewModelProtocol {
        return TweetCommentViewModel(item: item.comments[index])
    }
}
