//
//  CategoryModel.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import Foundation

struct Category {
    let id = UUID()
    let group: DishCategory
    let title: String
    let imageURL: String
    let dishes: [Dish]
}

var arrCategory = [
    Category(group: DishCategory.appetizer, title: "Appetizers", imageURL: "lemonPie", dishes: Dish.dishOfCat(cat: DishCategory.appetizer)),
    Category(group: DishCategory.main, title: "Mains", imageURL: "lemonPie", dishes: Dish.dishOfCat(cat: DishCategory.main)),
    Category(group: DishCategory.side, title: "Sides", imageURL: "lemonPie", dishes: Dish.dishOfCat(cat: DishCategory.side)),
    Category(group: DishCategory.dessert, title: "Desserts", imageURL: "lemonPie", dishes: Dish.dishOfCat(cat: DishCategory.dessert)),
    Category(group: DishCategory.drink, title: "Beverages", imageURL: "lemonPie", dishes: Dish.dishOfCat(cat: DishCategory.drink))
]



extension Category {
    
    static func all() -> [Category] {
        return arrCategory
    }
    
    static func categoryNum(n: Int) -> Category {
        return arrCategory[n]
    }

}
