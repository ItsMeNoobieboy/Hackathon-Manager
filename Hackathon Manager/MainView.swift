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
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ScheduleView()
                .tabItem() {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            MiscView()
                .tabItem() {
                    Image(systemName: "note.text")
                    Text("Misc")
                }
            handleProfileView()
                .tabItem() {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
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
