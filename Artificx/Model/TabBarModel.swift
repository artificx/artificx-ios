//
//  TabBarModel.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import SwiftUI

struct TabBarModel: Identifiable {
    
    let id = UUID()
    let index: Int
    let name: String
    let imageUrl: String
}

extension TabBarModel {
    
    static func all() -> [TabBarModel] {
        return [
            TabBarModel(index: 0, name: "Shop", imageUrl: "cart.fill"),
            TabBarModel(index: 1, name: "View", imageUrl: "camera.fill"),
            TabBarModel(index: 2, name: "Favorites", imageUrl: "heart.fill"),
            TabBarModel(index: 3, name: "Cart", imageUrl: "bag.fill"),
            TabBarModel(index: 4, name: "Profile", imageUrl: "person.fill")
        ]
    }
}
