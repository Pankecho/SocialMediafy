//
//  TweetFeedViewModel.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 12/05/24.
//

import Foundation

enum ViewModelState {
    case loading
    case success
    case failure
}

protocol TweetFeedViewModelProtocol {
    var tweetCount: Int { get }
    var state: Observer<ViewModelState> { get set }
    
    init(provider: TweetAPIProtocol)
    func getTweets()
    func getItem(at index: Int) -> TweetViewModelProtocol
}

final class TweetFeedViewModel: TweetFeedViewModelProtocol {
    private let provider: TweetAPIProtocol
    
    private var tweets: [Tweet] = [Tweet]()
    
    var state: Observer<ViewModelState> = Observer<ViewModelState>()

    var tweetCount: Int {
        return tweets.count
    }

    init(provider: TweetAPIProtocol) {
        self.provider = provider
    }

    func getTweets() {
        state.value = .loading
        provider.load() { result in
            switch result {
            case .success(let tweets):
                self.tweets = tweets
                self.state.value = .success
            case .failure(_):
                self.state.value = .failure
            }
        }
    }

    func getItem(at index: Int) -> TweetViewModelProtocol {
        return TweetViewModel(item: tweets[index])
    }
}
