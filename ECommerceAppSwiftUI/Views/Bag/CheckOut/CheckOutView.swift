//
//  CheckOutView.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import SwiftUI

struct CheckOutView: View {
    @State var navigationFlag = false

    func totalPrice(dishList: [Dish]) -> Double {
        var totalHolder = 0.0
        dishList.forEach() { Dish in
            totalHolder += (Dish.price * Double(Dish.numInCart))
    
        }
        return totalHolder
    }
    var tipPercent = 0.2
    fileprivate func SubmitButton() -> some View {
    
        Button(action: {
            self.navigationFlag = true
        }) {
            Text("Submit Order")
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
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .overlay(
            Text("Checkout")
                .font(.headline)
                .padding(.horizontal, 10)
                .background(Color.init(hex: "f9f9f9"))
            , alignment: .center)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(hex: "f9f9f9")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationBarView()
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Shipping Address")
                                    .font(.headline)
                                Spacer(minLength: 20)
                                Button(action: {
                                    
                                }) {
                                    Text("Change")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.top, 5)
                            
                            ZStack(alignment: .top) {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .shadow(color: Color.init(hex: "dddddd"), radius: 2, x: 0.8, y: 0.8)
                                VStack(alignment: .leading) {
                                    Text("Tianyi Gu")
                                        .padding(.top, 15)
                                    Text("180 Main Street  Andover, Massachussetts, US 01810")
                                        .padding(.top, 10)
                                        .padding(.bottom, 10)
                                        .lineLimit(nil)
                                }.padding(.horizontal, 5)
                            }.frame(height: 110)
                            
                            HStack {
                                Text("Payment")
                                    .font(.headline)
                                Spacer(minLength: 20)
                                Button(action: {
                                    
                                }) {
                                    Text("Change")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.top, 10)
                            
                            ZStack(alignment: .top) {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .shadow(color: Color.init(hex: "dddddd"), radius: 2, x: 0.8, y: 0.8)
                                HStack {
                                    Image("card")
                                        .resizable()
                                        .aspectRatio(4/3, contentMode: .fit)
                                    Text("**** **** **** 1234")
                                    Spacer()
                                }
                            }.frame(height: 80)
                            
                            HStack {
                                Text("Order:")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(String(format: "$%.02f", ((totalPrice(dishList: arrDish)) * (tipPercent + 1))))
                                    .bold()
                            }.padding(.top, 30)
                            
                            HStack {
                                Text("Delivery Charges:")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("$0")
                                    .bold()
                            }.padding(.top, 15)
                            
                            HStack {
                                Text("Total:")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(String(format: "$%.02f", ((totalPrice(dishList: arrDish)) * (tipPercent + 1))))
                                    .bold()
                            }.padding(.top, 15)
                            Spacer()
                        }.padding(15)
                    }
                    SubmitButton()
                    NavigationLink(destination: SuccessView(), isActive: self.$navigationFlag, label: {
                        EmptyView()
                    })
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}
