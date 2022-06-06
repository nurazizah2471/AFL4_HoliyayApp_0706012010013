//
//  DestinationData.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import Foundation
import Combine

class DestinationDataModel: ObservableObject {
    @Published var destinations: [DestinationModel] = getDestinations()
    @Published var profile = ProfileModel.default
    
    var categories: [String: [DestinationModel]] {
        Dictionary(
            grouping: destinations,
            by: { $0.category.rawValue }
        )
    }
}

func getDestinations() -> [DestinationModel] {
    if MyBookmarkModel.destinations.isEmpty {
        return load("destinationData.json")
    }
    return MyBookmarkModel.destinations
}

func load(_ filename: String) -> [DestinationModel] {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode([DestinationModel].self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as :\n\(error)")
    }
}
