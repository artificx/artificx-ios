//
//  ShopView.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import SwiftUI
import PartialSheet
/*
struct ShopView: View {
    
    let arrDish = Dish.all()
    
    @State private var isModalPresented: Bool = false
    @State private var sortedBy: String = "Price: lowest to high"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .overlay(
            Text("Shopping")
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
                VStack(alignment: .leading) {
                    NavigationBarView()
                    HStack {
                        Button(action: {
                            self.isModalPresented = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.up.arrow.down")
                                    .padding(.leading, 10)
                                Text(self.sortedBy)
                                    .padding(.trailing, 10)
                            }
                        }
                        .frame(height: 30)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.init(hex: "cb2d3e"), Color.init(hex: "ef473a")]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .font(.footnote)
                        .cornerRadius(15)
                        
                        Spacer()
                        
                        Button(action: {
                            print("Tapped on filter")
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                        }
                        .foregroundColor(.black)
                        .font(.body)
                    }
                    .padding(.init(top: 15, leading: 10, bottom: 0, trailing: 10))
                    
                    List(self.arrDish) { dish in
                        ItemCellTypeTwo(dish: dish, )
                    }
                    .background(Color.init(hex: "f9f9f9"))
                    .padding(.horizontal, -5)
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
            
        .partialSheet(presented: $isModalPresented) {
            VStack {
                Text("Sort By")
                    .font(.headline)
                    .padding()
                
                VStack(alignment: .leading) {
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Popular"
                    }) {
                        Text("Popular")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                        Spacer()
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Newest"
                        
                    }) {
                        Text("Newest")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Customer review"
                        
                    }) {
                        Text("Customer review")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Price: lowest to high"
                        
                    }) {
                        Text("Price: lowest to high")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                    
                    Button(action: {
                        // Do some action
                        self.isModalPresented = false
                        self.sortedBy = "Price: highest to low"
                        
                    }) {
                        Text("Price: highest to low")
                            .padding()
                            .foregroundColor(.black)
                            .font(.body)
                    }
                }.padding(.leading, 10)
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}

*/
