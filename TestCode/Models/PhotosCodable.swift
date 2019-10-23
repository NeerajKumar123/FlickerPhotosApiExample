//
//  PhotosCodable.swift
//  TestCode
//
//  Created by NeerajMac on 17/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import Foundation


struct Response:Decodable {
    let photosDetails : Details
    enum CodingKeys: String, CodingKey {
        case photosDetails = "photos"
    }
}

struct Details:Codable {
    let pageNum: Int
    let totalPages: Int
    let countPerPage:Int
    let photosArray:[PhotoCodable]
    
    enum CodingKeys: String, CodingKey {
        case pageNum = "page"
        case totalPages = "pages"
        case countPerPage = "perpage"
        case photosArray = "photo"
    }    
}

struct PhotoCodable: Codable {
    let id : String
    let farm : Int
    let server : String
    let secret : String
    
}

