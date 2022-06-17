//
//  NetworkRequest.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation

struct Request {
    enum Verb: String {
        case get = "GET"
    }

    enum Endpoint {
        case beers(page: Int, perPage: Int)

        func url(fromBase baseUrl: String) -> URL? {
            var urlComponents: URLComponents?

            switch self {
            case let .beers(pageCount, perPage):
                urlComponents = URLComponents(string: baseUrl + "beers")
                urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: pageCount.description))
                urlComponents?.queryItems?.append(URLQueryItem(name: "per_page", value: perPage.description))
            }

            return urlComponents?.url
        }
    }

    private let baseUrl = "https://api.punkapi.com/v2/"
    private let verb: Verb
    private let endpoint: Endpoint

    init(_ verb: Verb, endpoint: Endpoint) {
        self.verb = verb
        self.endpoint = endpoint
    }

    func urlRequest() -> URLRequest? {
        if let url = self.endpoint.url(fromBase: baseUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = verb.rawValue

            return request
        } else {
            return nil
        }
    }
}
