//
//  PostController.swift
//  Reddit
//
//  Created by Owen Barrott on 9/23/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

// https://www.reddit.com/r/funny/.json
import Foundation
import UIKit.UIImage

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
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let secondLevelDictionary = topLevelDictionary.data
                let thirdLevelObjects = secondLevelDictionary.children
                
                var postsPlaceholderArray: [Post] = []
                for object in thirdLevelObjects{
                    let post = object.data
                    postsPlaceholderArray.append(post)
                }
                completion(.success(postsPlaceholderArray))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnailFor(post: Post, completion: @escaping(Result<UIImage, PostError>) -> Void) {
        guard let url = post.thumbnail else {return completion(.failure(.invalidURL))}
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownImageError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            //The UIImage method decodes underneath the hood, but it doesn't throw. That's why we don't have to put it in a do-catch block.
            guard let thumbnailImage = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
                
                completion(.success(thumbnailImage))
        }.resume()
    }
}

    
