//
//  HomeView.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.red
            
            VStack{
                Image(systemName: "house.fill")
                    .font(.system(size: 64.0))
                Text("You are in Home view")
                    .font(.system(size: 32.0))
            }.foregroundColor(Color.white)
        }
    }
}

#Preview {
    HomeView()
}
