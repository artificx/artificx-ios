//
//  DishModel.swift
//  ECommerceAppSwiftUI
//
//  Created by Ayush Gupta on 27/11/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import Foundation
import SwiftUI

enum DishCategory: Int {
    case appetizer = 0
    case main
    case side
    case dessert
    case drink
}



class Dish: Identifiable {
    var id = UUID(),
        index: Int,
        name: String,
        description: String,
        imageURL: String,
        slideshowURL: [String],
        modelURL: String,
        price: Double,
        rating: Int,
        category: DishCategory,
        isFavorite: Bool,
        allergens: String,
        numInCart: Int
    
    init(index: Int, name: String, description: String, imageURL: String, slideshowURL: [String], modelURL: String, price: Double, rating: Int, category: DishCategory, isFavorite: Bool, allergens: String, numInCart: Int) {
            self.index = index
            self.name = name
            self.description = description
            self.imageURL = imageURL
            self.slideshowURL = slideshowURL
            self.modelURL = modelURL
            self.price = price
            self.rating = rating
            self.category = category
            self.isFavorite = isFavorite
            self.allergens = allergens
            self.numInCart = numInCart
    }
    
    func changeCart(increment: Int = 1) {
        self.numInCart = increment + numInCart
        print("mutated numInCart")
        print("\(numInCart)")
    }
}
    var arrDish = [
        Dish(index: 0, name: "Lemon Meringue Pie", description: "Delicious homemade pie crust, tart and smooth lemon filling, and fluffy toasted topping.", imageURL: "lemonPie", slideshowURL: ["lemonPie", "lemonPie", "lemonPie", "lemonPie"], modelURL: "placeholder", price: 15, rating: 5, category: DishCategory.dessert, isFavorite: true, allergens: "Contains Gluten, Dairy, Egg", numInCart: 0),
        Dish(index: 1, name: "Hot Chocolate", description: "Steamed milk and mocha sauce topped with sweetened whipped cream and a chocolate-flavored drizzle.", imageURL: "hotChocolate", slideshowURL: ["hotChocolate", "hotChocolate", "hotChocolate", "hotChocolate"], modelURL: "placeholder", price: 10, rating: 4, category: DishCategory.drink, isFavorite: false, allergens: "Contains Dairy", numInCart: 0),
        Dish(index: 2, name: "Reuben Sandwhich", description: "Corned beef, swiss cheese, and Sauerkraut on Rye bread", imageURL: "reubenSandwhich", slideshowURL: ["reubenSandwhich", "reubenSandwhich", "reubenSandwhich", "reubenSandwhich"], modelURL: "placeholder", price: 17, rating: 4, category: DishCategory.main, isFavorite: true, allergens: "Contains Gluten, Dairy", numInCart: 0),
        Dish(index: 3, name: "Meat Lover's Pizza", description: "Homemade thin crust pizza, topped with bufallo mozzarella, bacon, ham, peperonni, and sausage", imageURL: "meatPizza", slideshowURL: ["meatPizza", "meatPizza", "meatPizza", "meatPizza"], modelURL: "placeholder", price: 22.75, rating: 4, category: DishCategory.main, isFavorite: true, allergens: "Contains Gluten, Dairy", numInCart: 0),
        Dish(index: 4, name: "Bread Assortment", description: "Our artisan, housemade Sourdough and Rye breads, with your choice of dips", imageURL: "bread", slideshowURL: ["bread", "bread", "bread", "bread"], modelURL: "placeholder", price: 3, rating: 3, category: DishCategory.appetizer, isFavorite: false, allergens: "Contains Gluten", numInCart: 0),
        Dish(index: 5, name: "Chicken Dumplings", description: "Four steamed dumplings with chicken, ginger, and garlic. A chef's favorite.", imageURL: "dumplings", slideshowURL: ["dumplings", "dumplings", "dumplings", "dumplings"], modelURL: "placeholder", price: 6, rating: 5, category: DishCategory.side, isFavorite: true, allergens: "Contains Soy", numInCart: 0)
    ]

extension Dish {
    
    static func all() -> [Dish] {
        return arrDish
    }
    
    static func favorites() -> [Dish] {
        var favoriteArr: [Dish] = []
        let arrDishPlaceholder = Dish.all()
        
        arrDishPlaceholder.forEach() { Dish in
            if Dish.isFavorite {
                favoriteArr.append(Dish)
            }
        }
        return favoriteArr
    }
    
    static func inCart() -> [Dish] {
        var cartArr: [Dish] = []
        let arrDishPlaceholder = Dish.all()
        
        arrDishPlaceholder.forEach() { Dish in
            if Dish.numInCart != 0 {
                cartArr.append(Dish)
            }
        }
        return cartArr
    }
    static func numInCart() -> Int {
        var counter = 0
        let cartArr = inCart()
        
        cartArr.forEach() { Dish in
            counter = counter + 1
        }
        return counter
    }
    static func dishOfCat(cat: DishCategory) -> [Dish] {
        var categoryDishes: [Dish] = []
        let arrDishPlaceholder = Dish.all()
        
        arrDishPlaceholder.forEach() { Dish in
                if Dish.category == cat {
                    categoryDishes.append(Dish)
                }
        }
        return categoryDishes
    }

    
    
}


