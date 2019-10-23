//
//  ImageCache.swift
//  TestCode
//
//  Created by NeerajMac on 14/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import Foundation
import UIKit

class ImageCache{
    
    func getDirectoryPath() -> String {
        var documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentDirectoryPath)
        documentDirectoryPath.append("/imagefolder")
        return documentDirectoryPath
    }
    
    
    
    func saveImage(image: UIImage, forImageKey: String){
        let imageName = forImageKey.components(separatedBy: "/").last!
        let fm = FileManager.default
        let folderPath = getDirectoryPath()
        
        // check and create image folder inside document directory
        if !fm.fileExists(atPath: folderPath){
            try! fm.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        
        let imageData = image.jpegData(compressionQuality: 0.5)
        let folderUrl = URL(string: folderPath)
        let imageUrl  = folderUrl!.appendingPathComponent(imageName)
        let ret = fm.createFile(atPath: imageUrl.absoluteString, contents: imageData, attributes: nil)
        print(ret,imageUrl)
        
    }
    
    func getImageForKey(imageKey: String) -> UIImage? {
        let fm  = FileManager.default
        let folderPath = getDirectoryPath()
        let folderUrl = URL(string: folderPath)
        let imageName = imageKey.components(separatedBy: "/").last!
        let imageUrl  = folderUrl!.appendingPathComponent(imageName)
        
        if fm.fileExists(atPath: imageUrl.absoluteString){
            let image = UIImage(contentsOfFile: imageUrl.absoluteString)
            return image
        }
        return nil
    }
    
}
