//
//  SignupView.swift
//  Hackathon Manager
//
//  Created by Yancheng Zhao on 6/14/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = SignupViewViewModel()
    
    var body: some View {
        VStack {
            // Header
            // Header
            HeaderView(title: "HacKnight", subtitle: "Create an account for personal documents!", angle: -10, background: .green)
            
            // Signup Form
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                HMButton(title: "Create Account", backgroundColor: .green, textColor: .white) {
                    // Attempt account creation
                    viewModel.createAccount()
                }
                .padding()
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

#Preview {
    SignupView()
}
