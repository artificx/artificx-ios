//
//  Shopping.swift
//  ECommerceAppSwiftUI
//
//  Created by Ayush Gupta on 19/12/19.
//  Copyright © 2019 Ayush Gupta. All rights reserved.
//

import SwiftUI

struct Shopping: View {
    
    
    @State private var selectorIndex = 0
    @State private var needsRefresh = true
    @Binding var tabSelection : Int
    @State var descriptionDisplay = false
    @State var navigationFlag = false
    
    
    let arrCategory = Category.all()
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
        .frame(width: UIScreen.main.bounds.width, height: 35)
        .overlay(
            Text("Menu")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.primaryBlack)
                .padding(.horizontal, 10)
            , alignment: .center)
    }
    
    var body: some View {
        if needsRefresh {
        NavigationView {
            VStack {
                NavigationBarView()
                Picker("", selection: $selectorIndex) {
                    Text("Appetizers").tag(0)
                    Text("Mains").tag(1)
                    Text("Sides").tag(2)
                    Text("Desserts").tag(3)
                    Text("Beverages").tag(4)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
    
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    if tabSelection == 0 {
                    VStack(spacing: 10) {
                        ForEach(self.arrCategory[selectorIndex].dishes, id: \.id) { dish in
                            ItemCellTypeTwo(dish: dish, updateOutside: self.$needsRefresh, flag: self.$navigationFlag)
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                    })
         
                Spacer()
            }
            .edgesIgnoringSafeArea([.bottom, .horizontal])
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    }
}
/*
struct CategoryRow: View {
    
    var category: Category
    var selectorIndex = 0
    
    var body: some View {
        HStack {
            Text(self.category.title)
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.secondaryBlack)
                .padding(.leading, 20)
            Spacer()
            Image(self.category.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 2 - 15)
        }
        .background(Constants.AppColor.lightGrayColor)
        .cornerRadius(10)
    }
}
 */

struct ItemCellTypeTwo: View {
    
    let dish: Dish
    @Binding var updateOutside: Bool
    @Binding var flag: Bool

//Fix for tomorrow: need to display product information when click
    fileprivate func previewRect() -> some View {
        Button(action: {
            self.flag = true
            self.updateOutside = false
            self.updateOutside = true
        }) {
            Rectangle()
            .foregroundColor(.white)
            .cornerRadius(5)
            .shadow(color: Color.init(hex: "dddddd"), radius: 2, x: 0.8, y: 0.8)
        }
    }

    
    
    var body: some View {
        ZStack() {
            
            previewRect()
            NavigationLink(destination: ItemDetailsView(dish: dish), isActive: self.$flag, label: {
                EmptyView()
            })
            
            HStack() {
                Image(dish.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 170)
                    .cornerRadius(5)
                
                VStack(alignment: .leading) {
                    Text(dish.name)
                        .font(.headline)
                        .lineLimit(2)
                    
                        Button(action: {
                            dish.numInCart += 1
                            self.updateOutside = false
                            self.updateOutside = true
                            print(dish.numInCart)
                        }) {
                            Text("Add to Cart")
                                .font(.custom(Constants.AppFont.boldFont, size: 15))
                                .foregroundColor(.white)
                                .frame(height: 32)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "cb2d3e"), Color.init(hex: "ef473a")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(22)
                        }
                        .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
                    
                    HStack {
                        RatingView(rating: .constant(4))
                        Text("(\(dish.rating))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text(String(format: "$%.02f", dish.price))
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .bold()
                            .padding(.top, 5)
                        Spacer()
                        Button(action: {
                            dish.isFavorite.toggle()
                            self.updateOutside = false
                            self.updateOutside = true
                        }) {
                            Image(systemName: dish.isFavorite == true ? "heart.fill" : "heart")
                                .foregroundColor(dish.isFavorite == true ? .red :.gray)
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                        }
                        .cornerRadius(20)
                        .shadow(color: Color.init(hex: "dddddd"), radius: 2, x: 0.8, y: 0.8)
                    }
                }
                .padding(.init(top: 10, leading: 5, bottom: 5, trailing: 0))
                Spacer()
            }
            .frame(height: 170)
            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        
    }
   
    
}

/*
struct Shopping_Previews: PreviewProvider {
    static var previews: some View {
        Shopping(tabSelection: $selected)
    }
}
*/
