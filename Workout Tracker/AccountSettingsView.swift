//
//  AccountSettingsView.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/30/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct AccountSettingsView: View {
    @State private var showDeleteAlert = false
    @State private var email = ""
    @State private var isEmailCorrect = false // Replace with your validation logic
    
    var body: some View {
        NavigationStack {
            VStack {
                // List for Change Password
                List {
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                            .navigationBarBackButtonHidden(true)
            
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                Spacer()
                
                // Delete Account Button
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("Delete Account")
                        .foregroundColor(.red)
                        .bold()
                }
                .padding()
                .alert("Delete Account", isPresented: $showDeleteAlert, actions: {
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    Button("Confirm") {
                        if validateEmail(email) {
                            // Call your account deletion logic here
                            isEmailCorrect = true // Example: Replace with actual validation
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                }, message: {
                    Text("Are you sure you want to delete your account? This action cannot be undone.")
                })
            }
            .navigationTitle("Account Settings")
        }
    }
    
    
    // TODO
    // Replace this with your actual email validation logic
    func validateEmail(_ email: String) -> Bool {
        return !email.isEmpty && email.contains("@")
    }
}

// Create a custom back button component
struct BackButton3: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding()
        }
    }
}


struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView()
    }
}


