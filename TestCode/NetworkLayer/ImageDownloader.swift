//
//  ImageDownloader.swift
//  TestCode
//
//  Created by Guest1 on 12/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        
        // check if image is already cached..
        let imageCache = ImageCache()
        if let cachedImage =  imageCache.getImageForKey(imageKey: url.absoluteString){
            completion(cachedImage, nil)
        }
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            if let image =  UIImage(data: data){
                completion(image, nil)
                imageCache.saveImage(image: image, forImageKey: url.absoluteString)
            }
        }
    }
}
