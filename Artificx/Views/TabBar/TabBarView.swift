//
//  TabBarView.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import SwiftUI

struct TabBarView: View {
    
    @State var selected = 0
    
    var body: some View {
        ZStack {
            Color.init(hex: "f9f9f9")
                .edgesIgnoringSafeArea(.all)
            TabView(selection: $selected) {
                Shopping(tabSelection: $selected)
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Menu")
                    }.tag(0)
                BagView(tabSelection: $selected)
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Cart")
                    }.tag(1)
                ARMenu(tabSelection: $selected)
                    .tabItem {
                        Image(systemName: "camera.fill")
                        Text("View")
                    }.tag(2)
                FavoriteView(tabSelection: $selected)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorites")
                    }.tag(3)
                ProfileView(tabSelection: $selected)
                    .tabItem {
                        Image(systemName: "ellipsis.circle.fill")
                        Text("More")
                    }.tag(4)
            }
        }
        .accentColor(Color.init(hex: "DB3022"))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
