//
//  FavoriteView.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import SwiftUI
import PartialSheet

struct FavoriteView: View {
    
    var arrDish = Dish.all()
    @State private var isModalPresented: Bool = false
    @State private var sortedBy: String = ""
    @State var needsRefresh: Bool = true
    @State var showDetails: Bool = false
    @Binding var tabSelection : Int
    
    
    

    
    var arrSort = [
        "Popular",
        "Newest",
        "Customer Review",
        "Price: Lowest to high",
        "Price: Highest to low"
    ]
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Spacer()
            Button(action: {
                self.isModalPresented = true
            }) {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .frame(height: 30)
            .foregroundColor(Constants.AppColor.secondaryBlack)
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 35)
        .overlay(
            Text("Favorite")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.primaryBlack)
                .padding(.horizontal, 10)
            , alignment: .center)
    }
    
    var body: some View {
        
        
        if needsRefresh {
            
            VStack {
                NavigationBarView()
                ScrollView(.vertical, showsIndicators: false, content: {
                    if tabSelection == 3 {
                    VStack(spacing: 10) {
                        ForEach(self.arrDish, id: \.id) { dish in
                            if dish.isFavorite {
                                FavoriteRowNew(dish: dish, refreshOutside: self.$needsRefresh, flag: self.$showDetails)
                            }
                        }
                    }
                    }
                })
                .padding(.init(top: 5, leading: 15, bottom: 0, trailing: 15))
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

        
        .partialSheet(presented: $isModalPresented) {
            VStack {
                Text("Sort By")
                    .font(.headline)
                    .padding()
                
                VStack(alignment: .leading) {
                    ForEach(self.arrSort, id: \.self) { value in
                        Button(action: {
                            self.isModalPresented = false
                            self.sortedBy = value
                        }) {
                            Text(value)
                                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                                .padding()
                                .foregroundColor(self.sortedBy == value ? Constants.AppColor.secondaryRed : Constants.AppColor.secondaryBlack)
                                .font(.body)
                            Spacer()
                        }.frame(height: 40)
                    }
                    Spacer()
                }.padding(.leading, 10)
            }.frame(height: 250)
        }
        }
}
}

struct FavoriteRowNew: View {
    
    let dish: Dish
    @Binding var refreshOutside : Bool
    @Binding var flag: Bool
    
    fileprivate func FavoriteButton() -> some View {
        return Button(action: {
            print("Name: \(self.dish.name)")
            self.dish.isFavorite = false
            refreshOutside = false
            refreshOutside = true
        }) {
            Image(systemName: "multiply")
                .foregroundColor(.gray)
                .frame(width: 30, height: 30)
                .background(Color.white)
        }
        .cornerRadius(15)
        .opacity(0.8)
        .shadow(color: Color.init(hex: "dddddd"), radius: 0.5, x: 0.3, y: 0.3)
    }
    
    fileprivate func AddToBagButton() -> some View {
        return Button(action: {
            print("Name: \(self.dish.name)")
            self.dish.numInCart += 1
            refreshOutside = false
            refreshOutside = true
        }) {
            Image(systemName: "bag")
                .foregroundColor(.gray)
                .frame(width: 30, height: 30)
                .background(Color.white)
        }
        .cornerRadius(15)
        .opacity(0.8)
        .shadow(color: Color.init(hex: "dddddd"), radius: 0.5, x: 0.3, y: 0.3)
    }
    
    var body: some View {
                    
        HStack() {
                        Image(dish.imageURL).renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 100)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .cornerRadius(0)
                        
                        Button(action: {
                            self.flag = true
                            self.refreshOutside = false
                            self.refreshOutside = true
                        })
                        {
                        VStack(alignment: .leading) {
                            Text(dish.name)
                                .font(.custom(Constants.AppFont.semiBoldFont, size: 14))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .padding(.horizontal, 5)
                            
                            Text(dish.description)
                                .font(.custom(Constants.AppFont.regularFont, size: 11))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .padding(.top, -5)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Text(String(format: "$%.02f", dish.price))
                                    .font(.custom(Constants.AppFont.semiBoldFont, size: 13))
                                    .foregroundColor(Constants.AppColor.primaryBlack)
                            }
                            .padding(.init(top: 1, leading: 5, bottom: 5, trailing: 5))
                        }
                        }
                        NavigationLink(destination: ItemDetailsView(dish: dish), isActive: self.$flag, label: {
                            EmptyView()
                        })
                        
                        Spacer()
                        VStack {
                            FavoriteButton()
                                .padding(.bottom, 5)
                            AddToBagButton()
                        }
                        .padding(.horizontal, 5)
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 100, alignment: .leading)
                    LineView()
        
                }
        
        }
        
        
    

/*
struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(tabSelection: $selected)
    }
}
*/
