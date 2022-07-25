//
//  BagView.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import SwiftUI

struct BagView: View {
    var arrDish = Dish.all()
    @State var needsUpdate : Bool = true
    @State var navigationFlag = false
    @State var isShowPromoCodeView : Bool = false
    @Binding var tabSelection : Int
    var discount = 0
    var deliveryCharges = 0
    var tipPercent = 0.2
    
    func totalPrice(dishList: [Dish]) -> Double {
        var totalHolder = 0.0
        dishList.forEach() { Dish in
            totalHolder += (Dish.price * Double(Dish.numInCart))
    
        }
        return totalHolder
    }
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
        .padding(.horizontal, 15)
        .frame(width: UIScreen.main.bounds.width, height: 35)
        .overlay(
            Text("My Cart")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .foregroundColor(Constants.AppColor.primaryBlack)
                .padding(.horizontal, 10)
            , alignment: .center)
    }
    
    fileprivate func CheckOutButton() -> some View {
        Button(action: {
            self.navigationFlag = true
        }) {
            Text("CHECKOUT")
                .font(.custom(Constants.AppFont.boldFont, size: 15))
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "cb2d3e"), Color.init(hex: "ef473a")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(22)
        }
        .padding(.init(top: 0, leading: 15, bottom: 5, trailing: 15))
        
        
    }
/*
    fileprivate func ApplyCoupon() -> some View {
        return Button(action: {
            self.isShowPromoCodeView.toggle()
        }) {
            HStack {
                Image("offer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.leading, 15)
                    .foregroundColor(Constants.AppColor.primaryBlack)
                
                Text("APPLY COUPON")
                    .font(.custom(Constants.AppFont.regularFont, size: 13))
                    .foregroundColor(Constants.AppColor.primaryBlack)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .padding(.trailing, 15)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 30)
        .sheet(isPresented: $isShowPromoCodeView) {
        }
    }
*/
    
    var body: some View {
        if needsUpdate {
        
            NavigationView {

                VStack {
                    NavigationBarView()
                    ScrollView {
                        ZStack(alignment: .top) {
                            VStack {
                                ScrollView(.vertical, showsIndicators: false, content: {
                                    if tabSelection == 1 {
                                        VStack(spacing: 10) {
                                            ForEach(Dish.inCart(), id: \.id) { dish in
                                                ItemCellTypeThree(dish: dish, updateOutside: self.$needsUpdate)
                                            }
                                        }
                                        .padding(.horizontal, 15)
                                    }
                                })
                                .disabled(false)
                                .frame(height: (CGFloat(Dish.numInCart()) * 130) + 20) // It should be dynamic...
                                
                                LineView()
                                    .padding(.top, 5)
                                    .padding(.horizontal, 15)
                                
                                VStack {
                                    HStack {
                                        Text("Item Total")
                                            .font(.custom(Constants.AppFont.regularFont, size: 13))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                        Spacer()
                                        Text(String(format: "$%.02f", totalPrice(dishList: arrDish)))
                                            .font(.custom(Constants.AppFont.boldFont, size: 13))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                    }
                                    .padding(.top, 10)
                                    .padding(.horizontal, 15)
                                    
                                    HStack {
                                        Text("Tip")
                                            .font(.custom(Constants.AppFont.regularFont, size: 13))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                        Spacer()
                                        Text(String(format: "$%.02f", (totalPrice(dishList: arrDish) * tipPercent)))
                                            .font(.custom(Constants.AppFont.boldFont, size: 13))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                    }
                                    .padding(.top, 10)
                                    .padding(.horizontal, 15)
                                    
                                    
                                    LineView()
                                        .padding(.vertical, 5)
                                    
                                    HStack {
                                        Text("Total Amount")
                                            .font(.custom(Constants.AppFont.boldFont, size: 16))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                        Spacer()
                                        Text(String(format: "$%.02f", ((totalPrice(dishList: arrDish)) * (tipPercent + 1))))
                                            .font(.custom(Constants.AppFont.boldFont, size: 16))
                                            .foregroundColor(Constants.AppColor.secondaryBlack)
                                    }
                                }
                                .padding(.horizontal, 15)
                                .padding(.bottom, 5)
                                
                                Spacer()
                            }
                            .padding(.top, 2)
                        } .navigationBarHidden(true)
                    }
                    .padding(.top, 5)
                    Spacer()
                    CheckOutButton()
                    NavigationLink(destination: CheckOutView(), isActive: self.$navigationFlag, label: {
                        EmptyView()
                    })
                }
            }
            
        }
    }
}


    /*
     struct BagView_Previews: PreviewProvider {
     static var previews: some View {
     BagView(tabSelection: $selected)
     }
     }
     */
    struct ItemCellTypeThree: View {
        
        var dish: Dish
        @Binding var updateOutside: Bool
        @State var update: Bool = true
        
        
        fileprivate func plusButton() -> some View {
            return Button(action: {
                self.updateOutside = false
                self.updateOutside = true
                self.update.toggle()
                dish.changeCart(increment: 1)
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
                    .frame(width: 25, height: 25)
            }
        }
        
        fileprivate func numCounter() -> some View {
            if (update) {
                return Text("\(dish.numInCart)")
                
            } else {
                return Text("\(dish.numInCart)")
            }
        }
        
        fileprivate func minusButton() -> some View {
            return Button(action: {
                self.updateOutside = false
                self.updateOutside = true
                self.update.toggle()
                dish.changeCart(increment: -1)
            }) {
                Image(systemName: "minus")
                    .foregroundColor(.gray)
                    .frame(width: 25, height: 25)
            }
        }
        
        var body: some View {
            ZStack() {
                HStack(alignment: .top) {
                    Image(dish.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 120)
                        .cornerRadius(1)
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(dish.name)
                                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                                .foregroundColor(Constants.AppColor.secondaryBlack)
                                .lineLimit(1)
                            Spacer()
                            Button(action: {
                                self.updateOutside = false
                                self.updateOutside = true
                                self.update.toggle()
                                dish.changeCart(increment: (-1 * dish.numInCart))
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(Color.init(hex: "bbbbbb"))
                                    .padding(.top, 5)
                            }
                        }
                        
                        Text(dish.description)
                            .font(.custom(Constants.AppFont.regularFont, size: 11))
                            .foregroundColor(Constants.AppColor.secondaryBlack)
                            .padding(.top, -5)
                        
                        //   .padding(.top, 10)
                        
                        Spacer()
                        HStack {
                            HStack {
                                minusButton()
                                numCounter()
                                    .font(.custom(Constants.AppFont.semiBoldFont, size: 13))
                                    .foregroundColor(Constants.AppColor.secondaryBlack)
                                    .padding(.horizontal, 5)
                                plusButton()
                            }
                            .background(Constants.AppColor.lightGrayColor)
                            .cornerRadius(5)
                            .padding(.bottom, 10)
                            Spacer()
                            Text(String(format: "$%.02f", dish.price))
                                .font(.custom(Constants.AppFont.semiBoldFont, size: 14))
                                .foregroundColor(Constants.AppColor.primaryBlack)
                        }
                        
                    }
                    .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 0))
                    Spacer()
                }
                .frame(height: 130)
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
