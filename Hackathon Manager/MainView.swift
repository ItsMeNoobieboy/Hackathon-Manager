//
//  MainView.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/8/24.
//

import FirebaseCore
import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Label("Home", systemImage: "house.fill")
                }
            ScheduleView()
                .tabItem() {
                    Label("Schedule", systemImage: "calendar")
                }
            MiscView()
                .tabItem() {
                    Label("Misc", systemImage: "note.text")
                }
            handleProfileView()
                .tabItem() {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
    
    @ViewBuilder
    func handleProfileView() -> some View{
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // Signed in
            ProfileView()
        } else {
            LoginView()
        }
    }
}

    


#Preview {
    MainView()
}
