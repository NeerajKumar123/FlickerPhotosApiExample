//
//  NetworkHelper.swift
//  TestCode
//
//  Created by Interview on 12/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import Foundation


class NetworkHelper {
    static let shared = NetworkHelper()
    private init(){}
    var parsedPhotos = [Photo]?.self

//    func  getPhotos(text:String, pageNumber:Int, completion: @escaping ([Photo]?, Error?) -> Void){ //
//        //    let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
//
//        let escapedString = text.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
//
//        let completeUrl = "https://api.flickr.com/services/rest/?&method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=\(escapedString)&page=\(pageNumber)"
//        let url = URL(string:completeUrl)!
//        let session = URLSession(configuration: .default)
//        let datatask = session.dataTask(with: URLRequest(url: url)) { (data, res, err) in
//
//
//            if let data = data {
//                do {
//                    let jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//
//                    DispatchQueue.main.async
//                        {
//                            if (jsonResult.value(forKey: "stat") as! String == "ok")
//                            {
//                                if let photosDetails = jsonResult.value(forKey: "photos") as? NSDictionary
//                                {
//                                    var arr = [Photo]()
//
//                                    if let photos = photosDetails.value(forKey: "photo") as? NSArray
//                                    {
//                                        for photodetail in photos {
//                                            let photo = Photo(json: photodetail as! [String : Any])
//                                            arr.append(photo)
//                                        }
//                                        completion(arr, nil)
//                                    }
//                                }
//
//                            }else{
//                                let error = NSError(domain: "com.erro.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
//                                completion (nil, error)
//                            }
//                    }
//
//                } catch let error as NSError {
//                    completion (nil, error)
//                    print("Failed to load: \(error.localizedDescription)")
//                }
//            }
//        }
//        datatask.resume()
//    }

    
    func  getPhotos(text:String, pageNumber:Int, completion: @escaping ([PhotoCodable]?, Error?) -> Void){ //
        let escapedString = text.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
        
        let completeUrl = "https://api.flickr.com/services/rest/?&method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=\(escapedString)&page=\(pageNumber)"
        print("completeUrl",completeUrl)
        let url = URL(string:completeUrl)!
        let session = URLSession(configuration: .default)
        let datatask = session.dataTask(with: URLRequest(url: url)) { (data, res, err) in
            
            DispatchQueue.main.async {
                if let dataFetchingError =  err{
                    completion (nil, dataFetchingError)
                }
                if let dataFromServer = data {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(Response.self, from: dataFromServer)
                        print(response)
                        completion (response.photosDetails.photosArray, nil)
                    } catch {
                        print("Decoding Error :\(error)")
                        let decodingError = NSError(domain:"com.appname.decodingerror", code:10001, userInfo:nil)
                        completion (nil, decodingError)
                    }
                }else{
                    let datamissngError = NSError(domain:"com.appname.datamissing", code:10001, userInfo:nil)
                    completion (nil, datamissngError)
                    print("datamissngError")
                }
            }
            }
            
        datatask.resume()
    }

}

