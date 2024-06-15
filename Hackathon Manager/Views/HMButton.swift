//
//  HMButton.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/14/24.
//

import SwiftUI

struct HMButton: View {
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            // Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backgroundColor)
                Text(title)
                    .foregroundColor(textColor)
                    .bold()
            }
        }
    }
}

#Preview {
    HMButton(title: "Value", backgroundColor: .blue, textColor: .white) {
        
    }
}
