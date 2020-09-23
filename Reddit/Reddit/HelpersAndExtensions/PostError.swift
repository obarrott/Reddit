//
//  PostError.swift
//  Reddit
//
//  Created by Owen Barrott on 9/23/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case thrownImageError(Error)
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL"
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .noData:
            return "No data found"
        case .thrownImageError(let error):
            return "Could not display thumbnail image: \(error.localizedDescription)"
        case .unableToDecode:
            return "There was an error decoding the data"
        }
    }
}
