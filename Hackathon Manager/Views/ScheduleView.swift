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
                    
                    EventsView()
                } header: {
                    HeaderView()
                }
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // List Events
    func EventsView() -> some View {
        LazyVStack(spacing: 20) {
            if let events = viewModel.filteredEvents {
                
                if events.isEmpty {
                    Text("No events found!")
                        .font(.system(size:16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    ForEach(events) {event in
                        EventCardView(event: event)
                    }
                }
                
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        // Updating events if day changes
        .onChange(of: viewModel.currentDay) { newValue in
            viewModel.filterTodayEvents()
        }
    }
    
    // Event card View
    func EventCardView(event: Event) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(viewModel.isCurrentHour(date: event.date) ? .black : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth:1)
                            .padding(-3)
                    )
                    .scaleEffect(!viewModel.isCurrentHour(date: event.date) ? 0.8 : 1)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack {
                
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(event.title)
                            .font(.title2.bold())
                        Text(event.description)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(event.date.formatted(date: .omitted, time: .shortened))
                }
                
            }
            .foregroundColor(viewModel.isCurrentHour(date: event.date) ? .white : .black)
            .padding(viewModel.isCurrentHour(date: event.date) ? 15 : 0)
            .padding(.bottom, viewModel.isCurrentHour(date: event.date) ? 0 : 10)
            .hLeading()
            .background(
                Color(.black)
                    .cornerRadius(25)
                    .opacity(viewModel.isCurrentHour(date: event.date) ? 1 : 0)
            )
            
        }
        .hLeading()
    }
    
    // Header
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Schedule")
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
        .padding(.top, getSafeArea().top)
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
    
    // Safe Area
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
