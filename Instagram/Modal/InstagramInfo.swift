//
//  InstagramInfo.swift
//  Instagram
//
//  Created by MTQ on 6/29/20.
//  Copyright © 2020 seesaa. All rights reserved.
//

import Foundation

struct InstagramInfo {
    var mosaicSegmentStyle: MosaicSegmentStyle?
    let type: InstagramType
    let url: String
    
    init(dict: [String: Any]) {
        self.mosaicSegmentStyle = MosaicSegmentStyle(rawValue: dict["mosaicSegmentStyle"] as? String ?? "")
        self.type = InstagramType(rawValue: dict["type"] as! String)!
        self.url = dict["url"] as! String
    }
}
