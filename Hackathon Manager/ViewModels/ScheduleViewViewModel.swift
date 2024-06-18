//
//  ScheduleViewViewModel.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/14/24.
//

import Foundation

class ScheduleViewViewModel: ObservableObject{
    
    @Published var storedEvents: [Event] = [
        Event(title: "Check-in", description: "Check into HacKnight!", date:
                .init(timeIntervalSince1970: 1717246800)),
        Event(title: "Opening Ceremony", description: "Welcome event", date:
                .init(timeIntervalSince1970: 1717250400)),
        Event(title: "Workshop 1", description: "Your first learnathon workshop!", date:
                .init(timeIntervalSince1970: 1717252200)),
        Event(title: "Lunch", description: "Costco pizza!", date:
                .init(timeIntervalSince1970: 1717257600)),
        Event(title: "Workshop 2", description: "Your second learnathon workshop!", date:
                .init(timeIntervalSince1970: 1717261200)),
    ]
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    
    init() {
        fetchCurrentWeek()
    }
    
    // Return the current week's days
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    // Convert Date to String
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // Check if current Date is today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
