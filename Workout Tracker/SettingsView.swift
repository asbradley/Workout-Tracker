//
//  SettingsView.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/30/24.
//

import Foundation
import SwiftUI
import FirebaseAuth


struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    // Account Section
                    Section("Account") {
                        NavigationLink(destination: Text("Profile Settings")) {
                            HStack {
                                Image(systemName: "person.fill")
                                Text("Profile")
                            }
                        }
                        
                        NavigationLink(destination: AccountSettingsView()) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                Text("Account")
                            }
                        }
                    }
                    
                    // Preferences Section
                    Section("Preferences") {
                        NavigationLink(destination: Text("Units Settings")) {
                            HStack {
                                Image(systemName: "ruler.fill")
                                Text("Units")
                            }
                        }
                        
                        NavigationLink(destination: Text("Theme Settings")) {
                            HStack {
                                Image(systemName: "paintbrush.fill")
                                Text("Theme")
                            }
                        }
                    }
                }
                
                // Logout Button at bottom
                Button(action: {
                    // Handle logout
                    do {
                        try Auth.auth().signOut()
                        // Handle post-logout navigation
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }) {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Settings")

        }
    }
}




struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}



