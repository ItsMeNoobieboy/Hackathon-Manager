//
//  LoginView.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "HacKnight", subtitle: "Log in to view personal documents!", angle: 10, background: .blue)
                
                // Login Form
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(Color.red)
                    }
                    
                    HMButton(title: "Log In", backgroundColor: .blue, textColor: .white) {
                        // Attempt log in
                        viewModel.logIn()
                    }
                    .padding()
                }
                .offset(y: -50)
                
                // Create Account
                VStack {
                    Text("Don't have an account?")
                    NavigationLink("Create an account", destination: SignupView())
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
            
        }
    }
    
}

#Preview {
    LoginView()
}
