//
//  SuccessView.swift
//  ArtificxSwiftUI
//
//  Created by Tianyi and Jack on 23/7/22.
//
//

import SwiftUI

struct SuccessView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Image("success")
                .resizable()
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fit)
            Text("Success!")
                .font(.largeTitle)
                .padding(.vertical, 10)
            Text("Your order will arrive soon. Thank you for ordering with Artificx.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
