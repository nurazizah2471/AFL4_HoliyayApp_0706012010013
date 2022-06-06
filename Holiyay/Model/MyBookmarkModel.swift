//
//  MyBookmark.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import Foundation

struct MyBookmarkModel {
    static var destinations: [DestinationModel] = []
    
    static func setup() {
        if destinations.isEmpty {
            destinations = load("destinationData.json")
        }
    }
}
