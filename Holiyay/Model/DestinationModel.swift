//
//  Destination.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct DestinationModel: Hashable, Codable, Identifiable {
    var name: String
    var category: Category
    var city: String
    var country: String
    var id: Int
    var isBookmark: Bool
    var plandate: String
    var description: String
    private var coordinates: Coordinates
    private var imageExploreBookmark: String
    
    enum Category: String, CaseIterable, Codable {
        case beaches = "Beaches"
        case deserts = "Deserts"
        case forests = "Forests"
        case mountains = "Mountains"
    }

    var thumbnail: Image {
        Image(imageExploreBookmark)
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
