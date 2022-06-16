//
//  NetworkWorker.swift
//  WorldBeers
//
//  Created by Franco Consoni on 16/06/2022.
//

import Foundation
import Combine

protocol NetworkWorkable {
    func make(_ request: Request) -> AnyPublisher<Data, NetworkError>
}

struct NetworkWorker: NetworkWorkable {
    func make(_ request: Request) -> AnyPublisher<Data, NetworkError> {
        if let request = request.urlRequest() {
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .mapError { urlError in
                    return NetworkError.generic(urlError)
                }
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidUrl
    case generic(URLError)

    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Error"
        case .generic( let error):
            return error.localizedDescription
        }
    }
}
