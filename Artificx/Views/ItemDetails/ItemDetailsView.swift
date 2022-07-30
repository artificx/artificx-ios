//
//  ItemDetailsView.swift
//  ECommerceAppSwiftUI
//
//  Created by Jack Doyle on 7/26/22.
//  Copyright © 2022 Tianyi. All rights reserved.
//

import SwiftUI

struct ItemDetailsView: View {
    
    @State var index = 0
    @State private var isModalPresentedForColor: Bool = false
    @State private var isModalPresentedForSize: Bool = false
    @State private var color: String = ""
    @State private var size: String = ""
    @State var refresh : Bool = true

    let dish: Dish
    let arrDish = Dish.all()
    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
//        .padding(.horizontal, 15)
//        .frame(width: UIScreen.main.bounds.width, height: 35)
//        .overlay(
//            Text("Details")
//                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
//                .foregroundColor(Constants.AppColor.primaryBlack)
//                .padding(.horizontal, 10)
//            , alignment: .center)
    }
    
    
    fileprivate func FavoriteButton() -> some View {
        return Button(action: {
            dish.isFavorite.toggle()
            self.refresh = false
            self.refresh = true
        }) {
            Image(systemName: self.dish.isFavorite == true ? "heart.fill" : "heart")
                .foregroundColor(self.dish.isFavorite == true ? .red : Constants.AppColor.secondaryBlack)
                .frame(width: 35, height: 35)
            //.background(Color.white)
        }
        .cornerRadius(20)
        //                .shadow(color: Constants.AppColor.shadowColor, radius: 2, x: 0.8, y: 0.8)
    }
    
    fileprivate func ImageSlider() -> some View {
        return PagingView(index: $index.animation(), maxIndex: self.dish.slideshowURL.count - 1) {
            ForEach(self.dish.slideshowURL, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .aspectRatio(4/3, contentMode: .fit)
//        .frame(width: UIScreen.main.bounds.width, height: 250)
    }
    
//    fileprivate func SimilarProduct() -> some View {
//        return VStack(alignment: .leading) {
//            HStack {
//                Text("Similar Products")
//                    .font(.custom(Constants.AppFont.boldFont, size: 15))
//                    .foregroundColor(Constants.AppColor.secondaryBlack)
//                    .padding(.leading, 15)
//
//                Spacer(minLength: 10)
//
//                Button(action: {
//
//                }) {
//                    Text("See All")
//                        .padding(.trailing, 15)
//                        .font(.custom(Constants.AppFont.semiBoldFont, size: 12))
//                        .foregroundColor(Constants.AppColor.secondaryRed)
//                }
//            }
//            .padding(.top, 8)
//
//            ScrollView(.horizontal, showsIndicators: false, content: {
//                HStack(spacing: 10) {
//                    ForEach(self.arrDish) { dish in
//                        ItemCellTypeTwo(dish: dish, updateOutside: self.$show, )
//                    }
//                }.padding(.leading, 15)
//            })
//        }.background(Color.white)
//    }
    
    fileprivate func AddToCartButton() -> some View {
            Button(action: {
                self.dish.numInCart += 1
            }) {
                Text("Add To Cart")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "cb2d3e"), Color.init(hex: "ef473a")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(25)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
        //        Button(action: {
//            dish.numInCart += 1
//        }) {
//            Text("")
//                .frame(height: 65)
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .background(Constants.AppColor.gradientRedHorizontal)
//                .cornerRadius(0)
//        }
//        .padding(.horizontal, 0)
//        .overlay(
//            Text("Add To Cart")
//                .font(.custom(Constants.AppFont.boldFont, size: 15))
//                .foregroundColor(.white)
//                .padding(.top, -10)
//        )
    

/* Select size and color: unecessary
    fileprivate func SelectSizeView() -> some View {
        return VStack(alignment: .leading) {
            Text("Select Size")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.secondaryBlack)
                .padding(.top, 10)
            
            HStack {
                ForEach(self.arrSize, id: \.self) { size in
                    Button(action: {
                        self.size = size
                    }) {
                        Text(size)
                            .font(.custom(Constants.AppFont.semiBoldFont, size: 13))
                            .foregroundColor(self.size == size ? Constants.AppColor.secondaryRed : Constants.AppColor.secondaryBlack)
                            .frame(width: 40, height: 30)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(self.size == size ? Constants.AppColor.secondaryRed : Constants.AppColor.secondaryBlack, lineWidth: self.size == size ? 1.0 : 0.3))
                }
                Spacer()
            }
            .padding(.top, 15)
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 15)
        .background(Color.white)
        .padding(.bottom, 5)
    }
    
    fileprivate func SelectColorView() -> some View {
        return VStack(alignment: .leading) {
            Text("Select Color")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.secondaryBlack)
                .padding(.top, 10)
            
            HStack {
                ForEach(self.arrColor, id: \.self) { color in
                    Button(action: {
                        self.color = color
                    }) {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.init(hex: color))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Constants.AppColor.secondaryRed, lineWidth: self.color == color ? 1.0 : 0))
                }
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 15)
        .background(Color.white)
    }
*/
    var body: some View {
        if refresh {
        VStack {
            NavigationBarView()
            ScrollView {
                ZStack {
                    Constants.AppColor.lightGrayColor
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading) {
                        ImageSlider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer(minLength: 10)
                                HStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.white)
                                        .padding(.leading, 6)
                                    
                                    Text("\(dish.rating).0")
                                        .font(.custom(Constants.AppFont.regularFont, size: 12))
                                        .foregroundColor(.white)
                                        .padding(.trailing, 6)
                                }.frame(height: 20)
                                    //                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    //                                .stroke(Color.green, lineWidth: 0.5))
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding([.horizontal], 15)
                            .padding(.top, 8)
                            
                            Text(dish.name)
                                .font(.custom(Constants.AppFont.lightFont, size: 13))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .lineLimit(nil)
                                .padding([.horizontal], 15)
                                .padding(.top, -5)
                                .padding(.bottom, 5)
                            
                            HStack {
                                Text(String(format: "$%.02f", dish.price))
                                    .font(.custom(Constants.AppFont.boldFont, size: 14))
                                    .foregroundColor(Constants.AppColor.secondaryBlack)
                                Spacer()
                            }
                            .padding(.bottom, 8)
                            .padding(.horizontal, 15)
                        }
                        .background(Color.white)
                        .padding(.bottom, 5)
                        
                        VStack(alignment: .leading) {
                            Text("Product Details")
                                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .padding(.top, 10)
                                .padding(.horizontal, 15)
                                .multilineTextAlignment(.leading)
                            Text(dish.description)
                                .font(.custom(Constants.AppFont.lightFont, size: 13))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .padding(.vertical, 8)
                                .lineSpacing(2)
                                .padding(.horizontal, 15)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
    
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.white)
                        .padding(.top, -3)
                        .multilineTextAlignment(.leading)
                        
                        VStack(alignment: .leading) {
                            Text("Allergens")
                                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .padding(.top, 10)
                                .padding(.horizontal, 15)
                                .multilineTextAlignment(.leading)

                            Text(dish.allergens)
                                .font(.custom(Constants.AppFont.lightFont, size: 13))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .padding(.vertical, 8)
                                .lineSpacing(2)
                                .padding(.horizontal, 15)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.white)
                        .padding(.top, -3)
                        .multilineTextAlignment(.leading)
                        
//                        SimilarProduct()
//                            .padding(.init(top: 5, leading: 0, bottom: 10, trailing: 0))
                    }
                }
            }
            AddToCartButton()
        }   .navigationBarTitle(Text("Details"), displayMode: .inline)
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
    }
    }
}
//
//struct ItemDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailsView()
//    }
//}
