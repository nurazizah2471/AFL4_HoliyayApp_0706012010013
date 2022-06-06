//
//  MyBookmark.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import Foundation

struct MyBookmark {
    static var destinations: [Destination] = []
    
    static func setup() {
        if destinations.isEmpty {
            destinations = load("destinationData.json")
        }
    }
}
