//
//  Landmark.swift
//  bannerView
//
//  Created by cc on 2020/10/30.
//

import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    var state: String
    var park: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool

    var featureImage: Image? {
        guard isFeatured else { return nil }
        
        return Image("\(imageName)_feature")
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
}
