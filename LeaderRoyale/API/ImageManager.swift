//
//  ImageManager.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

typealias ImageCompletion = (_ url: String, _ image: UIImage?) -> Void

class ImageManager {
    
    private static var imageCache = [String : UIImage]()
    
    static func getImage(url: String, completion: @escaping ImageCompletion) {
        if let image = imageCache[url] {
            completion(url, image)
        } else {
            download(urlString: url, completion: completion)
        }
    }

    private static func download(urlString: String, completion: @escaping ImageCompletion) {
        guard let url = URL(string: urlString) else {
            completion(urlString, nil)
            return
        }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(urlString, UIImage(data: data))
            } else {
                completion(urlString, nil)
            }
        }
        
        downloadTask.resume()
    }
    
}
