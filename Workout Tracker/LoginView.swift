//
//  LoginView.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/29/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var navigateToProfile: Bool = false
    @State private var showForgotPassword: Bool = false
    @State private var showSuccessMessage: Bool = false  // New state for success popup
    @State private var resetEmail: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Your existing gradient and content...
                
                LinearGradient(
                                gradient: Gradient(colors: [.red, .black]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .edgesIgnoringSafeArea(.all)

                            VStack(spacing: 20) {
                                // Log In Header
                                Text("Log In")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .padding(.top, 50)

                                // Email and Password Input Fields
                                VStack(alignment: .leading) {
                                    TextField("Email", text: $email)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.bottom)

                                    SecureField("Password", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.bottom)
                                }
                                .padding()

                                // Log In Button
                                Button(action: {
                                    login()
                                }) {
                                    Text("Log In")
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .padding(.horizontal)

                                // Forgot Password Link
                                Button(action: {
                                    forgotPassword()
                                }) {
                                    Text("Forgot Password?")
                                        .foregroundColor(.white)
                                        .underline()
                                }
                                .padding(.top)

                                Spacer()
                            }
                            .padding()
                
                
                // Forgot Password popup
                if showForgotPassword {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                Text("Reset Password")
                                    .font(.headline)
                                    .padding(.top)
                                
                                TextField("Enter your email", text: $resetEmail)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                HStack {
                                    Button(action: {
                                        showForgotPassword = false
                                    }) {
                                        Text("Cancel")
                                            .foregroundColor(.red)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                    }
                                    
                                    Button(action: {
                                        sendPasswordReset()
                                    }) {
                                        Text("Reset")
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color.red)
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal, 40)
                        )
                        .zIndex(1)
                }
                
                // Success Message popup
                if showSuccessMessage {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                Text("Success!")
                                    .font(.headline)
                                    .padding(.top)
                                
                                Text("Password reset email has been sent to \(resetEmail)")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                
                                Button(action: {
                                    showSuccessMessage = false
                                }) {
                                    Text("OK")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.red)
                                        .cornerRadius(10)
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal, 40)
                        )
                        .zIndex(2)  // Ensure success popup appears above everything
                }
            }
        }
        .fullScreenCover(isPresented: $navigateToProfile) {
            ProfileView()
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                print("Information not found in database")
            } else {
                print("Log in successful!")
                navigateToProfile = true
            }
        }
    }
    
    func forgotPassword() {
        resetEmail = email  // Pre-fill with current email if any
        showForgotPassword = true
    }
    
    
    func sendPasswordReset() {
        Auth.auth().sendPasswordReset(withEmail: resetEmail) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                showForgotPassword = false  // Hide the forgot password popup
                showSuccessMessage = true   // Show the success message
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
