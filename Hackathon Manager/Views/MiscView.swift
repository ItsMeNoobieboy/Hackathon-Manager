//
//  MiscView.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/8/24.
//

import SwiftUI

struct MiscView: View {
    var body: some View {
        ZStack {
            Color.green
            
            VStack{
                Image(systemName: "note.text")
                    .font(.system(size: 64.0))
                Text("You are in Misc view")
                    .font(.system(size: 32.0))
            }.foregroundColor(Color.white)
        }
    }
}

#Preview {
    MiscView()
}
