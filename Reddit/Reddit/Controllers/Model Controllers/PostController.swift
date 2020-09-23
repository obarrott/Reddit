//
//  PostController.swift
//  Reddit
//
//  Created by Owen Barrott on 9/23/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

// https://www.reddit.com/r/funny/.json
import Foundation

struct StringConstants {
    fileprivate static let baseURL = "https://www.reddit.com" //fileprivate allows this struct to only be accsessed within this file. "private" only allows it within the class
    fileprivate static let rEndpoint = "r"
    fileprivate static let funnyEndpoint = "funny"
    fileprivate static let jsonExtension = "json"
    
    
}

class PostController {
    
     //You only need a shared instance when you need to update, add, delete the source of truth. In this case we're just fetching data and displaying it, so we don't need a singleton.
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL))}
        
        let rComponentURL = baseURL.appendingPathComponent(StringConstants.rEndpoint)
        let funnyComponentURL = rComponentURL.appendingPathComponent(StringConstants.funnyEndpoint)
        let finalURL = funnyComponentURL.appendingPathExtension(StringConstants.jsonExtension)
        print(finalURL) //Always do this to make sure that your URL is working.
        
        }
    }
    
