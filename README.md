# Social Mediafy 

This README file contains the instructions for Social Mediafy, a Technical Test for KingTide 

# How to run
For running the project, just clone it in your local and _Build & Run_.

# The Project
The project is a twitter-like app that will be displaying tweets in a timeline. When you click the cell it will route you to a Detail screen where you will be able to see 

https://github.com/Pankecho/SocialMediafy/assets/10101707/add78c68-94b1-4109-8a3a-5fc0ff1589e4

# Testing
For the project I made 45% of Test Coverage, the only part I didnt add test were for UI and Integration UI and ViewModel
<img width="1229" alt="image" src="https://github.com/Pankecho/SocialMediafy/assets/10101707/5b6520bc-45c9-4cd0-97f3-3227e967a93e">

# Technical stuff

For the mock of the feed and detail I implemented

`https://designer.mocky.io`

```
enum Endpoint {
    static let baseURL = "https://run.mocky.io/v3"
    
    case timeline
    case getTweet(id: String)
    case likeTweet(id: String)
    case postTweet(text: String)
    case commentTweet(id: String, comment: String)
}

extension Endpoint {
    var string: String {
        switch self {
        case .timeline:
            return "/8dfa01c8-68c3-486b-b566-e0668b587101"
        case .getTweet(_):
            return "/a8dc2e18-372e-4395-90e4-b1990ac1da5e"
        case .postTweet(_):
            return "/api/tweet"
        case .likeTweet(let id):
            return "/api/tweet/\(id)/like"
        case .commentTweet(let id, _):
            return "/api/tweet/\(id)/comment"
        }
    }
    
    var request: URLRequest {
        switch self {
        case .timeline, .getTweet(_):
            let url = URL(string: Endpoint.baseURL + string)!
            return URLRequest(url: url)
        case .likeTweet(_):
            let url = URL(string: Endpoint.baseURL + string)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        case .commentTweet(_, let comment):
            let url = URL(string: Endpoint.baseURL + string)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let data = try? JSONEncoder().encode(CreationRequest(text: comment))
            request.httpBody = data
            return request
        case .postTweet(let text):
            let url = URL(string: Endpoint.baseURL + string)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let data = try? JSONEncoder().encode(CreationRequest(text: text))
            request.httpBody = data
            return request
        }
    }
}

```

