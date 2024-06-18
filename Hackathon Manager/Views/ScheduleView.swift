//
//  ScheduleView.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/8/24.
//

import SwiftUI
import UIKit

struct ScheduleView: View {
    @StateObject var viewModel: ScheduleViewViewModel = ScheduleViewViewModel()
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    
                    // Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            
                            ForEach(viewModel.currentWeek, id: \.self) { day in
                                VStack(spacing: 10) {
                                    Text(viewModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size:15))
                                        .fontWeight(.semibold)
                                    
                                    // EEE returns as MON, TUE, etc
                                    Text(viewModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size:14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(viewModel.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(viewModel.isToday(date:day) ? .primary : .secondary)
                                .foregroundColor(viewModel.isToday(date:day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    
                                    ZStack {
                                        // Matched Geometry Effect
                                        if viewModel.isToday(date: day) {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                    
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    // Update current day
                                    withAnimation {
                                        viewModel.currentDay = day
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        
                    }
                } header: {
                    
                }
            }
        }
    }
    
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ScheduleView()
}

// UI Design Helper functions
extension View {
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
