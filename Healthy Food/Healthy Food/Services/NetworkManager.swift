//
//  NetworkManager.swift
//  Healthy Food
//
//  Created by Kyzu on 3.10.22.
//

import Foundation
import UIKit

class NetworkManager {
    
    var imageCach = NSCache<NSString, UIImage>()
    
    func getImageForArticle(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if let cachedImage = imageCach.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
        } else {
            
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            
            URLSession.shared.dataTask(with: request) {(data, _, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    print("Empty data")
                    return
                }
                
                guard let image = UIImage(data: data) else { return }
                self.imageCach.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(.success(image))
                }
                
            }.resume()
        }
    }
    
}
