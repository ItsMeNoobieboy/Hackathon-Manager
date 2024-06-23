//
//  ScheduleViewViewModel.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/14/24.
//

import Foundation
import SwiftUI

class ScheduleViewViewModel: ObservableObject{
    
    @Published var storedEvents: [Event] = [
        Event(title: "Check-in", description: "Learnathon!", startTime: .init(timeIntervalSince1970: 1717246800+1468800), endTime: .init(timeIntervalSince1970: 1717250400+1468800)),
        Event(title: "Opening Ceremony", description: "Learnathon", startTime: .init(timeIntervalSince1970: 1717250400+1468800), endTime: .init(timeIntervalSince1970: 1717252200+1468800)),
        Event(title: "Workshop 1", description: "Your first learnathon workshop!", startTime: .init(timeIntervalSince1970: 1717252200+1468800), endTime: .init(timeIntervalSince1970: 1717257600+1468800)),
        Event(title: "Lunch", description: "Costco pizza!", startTime: .init(timeIntervalSince1970: 1717257600+1468800), endTime: .init(timeIntervalSince1970: 1717261200+1468800)),
        Event(title: "Workshop 2", description: "Your second learnathon workshop!", startTime: .init(timeIntervalSince1970: 1717261200+1468800), endTime: .init(timeIntervalSince1970: 1717266600+1468800)),
        Event(title: "Closing Ceremony", description: "Learnathon", startTime: .init(timeIntervalSince1970: 1717266600+1468800), endTime: .init(timeIntervalSince1970: 1717268400+1468800)),
        Event(title: "Check-in", description: "Overnight hackathon", startTime: .init(timeIntervalSince1970: 1717275600+1468800), endTime: .init(timeIntervalSince1970: 1717279200+1468800)),
        Event(title: "Opening Ceremony", description: "Hackathon", startTime: .init(timeIntervalSince1970: 1717279200+1468800), endTime: .init(timeIntervalSince1970: 1717282800+1468800)),
        Event(title: "Dinner", description: "Comella's Pasta!", startTime: .init(timeIntervalSince1970: 1717282800+1468800), endTime: .init(timeIntervalSince1970: 1717286400+1468800)),
        Event(title: "Hacking!", description: "Time to work on your projects", startTime: .init(timeIntervalSince1970: 1717282800+1468800), endTime: .init(timeIntervalSince1970: 1717358400+1468800)),
        Event(title: "Boba Drops Workshop", description: "Hosted by Hack Club!", startTime: .init(timeIntervalSince1970: 1717293600+1468800), endTime: .init(timeIntervalSince1970: 1717297200+1468800)),
        Event(title: "Late Night Games", description: "Take a break from the hacking!", startTime:  .init(timeIntervalSince1970: 1717297200+1468800), endTime: .init(timeIntervalSince1970: 1717300800+1468800)),
        Event(title: "Breakfast", description: "Croissants, muffins, bagels, and more!", startTime: .init(timeIntervalSince1970: 1717329600+1468800), endTime: .init(timeIntervalSince1970: 1717333200+1468800)),
        Event(title: "Check-in", description: "Day hackathon", startTime: .init(timeIntervalSince1970: 1717329600+1468800), endTime: .init(timeIntervalSince1970: 1717333200+1468800)),
        Event(title: "Lunch", description: "Otto Pizza!", startTime: .init(timeIntervalSince1970: 1717345800+1468800), endTime: .init(timeIntervalSince1970: 1717349400+1468800)),
        Event(title: "Hack Scoop Workshop", description: "Hosted by Hack Club!", startTime: .init(timeIntervalSince1970: 1717351200+1468800), endTime: .init(timeIntervalSince1970: 1717354800+1468800)),
        Event(title: "Presentations", description: "Science-fair like showcase", startTime:  .init(timeIntervalSince1970: 1717360200+1468800), endTime: .init(timeIntervalSince1970: 1717363800+1468800)),
        Event(title: "Closing Ceremony", description: "Bye HacKnight!", startTime:  .init(timeIntervalSince1970: 1717363800+1468800), endTime: .init(timeIntervalSince1970: 1717365600+1468800)),
    ]
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var filteredEvents: [Event]?
    
    init() {
        fetchCurrentWeek()
        filterTodayEvents()
    }
    
    func filterTodayEvents() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            
            let filtered = self.storedEvents.filter {
                return calendar.isDate($0.startTime, inSameDayAs: self.currentDay) || calendar.isDate($0.endTime, inSameDayAs: self.currentDay)
            }
                .sorted { event1, event2 in
                    return event1.startTime == event2.startTime ? event1.endTime < event2.endTime : event1.startTime < event2.startTime
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredEvents = filtered
                }
            }
            
            //            print("Filtering for \(self.currentDay)")
            //            print(filtered)
        }
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
    
    // Check if an event is during the current hour
    func isCurrentHour(date: Date) -> Bool {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
    
    // Check if an event is happening during the current time
    func isCurrent(event: Event) -> Bool {
        let rightNow = Date()
        
        return event.startTime <= rightNow && rightNow <= event.endTime
    }
}
