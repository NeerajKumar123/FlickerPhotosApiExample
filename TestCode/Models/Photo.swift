//
//  Photos.swift
//  TestCode
//
//  Created by Interview on 12/10/19.
//  Copyright © 2019 Interview. All rights reserved.
//

import Foundation
struct Photo {
    let id : String
    let farm : Int
    let server : String
    let secret : String
    
    init(json: [String: Any]) {
        self.id = json["id"] as! String
        self.farm = json["farm"] as! Int
        self.server = json["server"] as! String
        self.secret = json["secret"] as! String
    }
}
