//
//  ProfileView.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/29/24.
//

import SwiftUI
import FirebaseAuth


struct ProfileView: View {
    @State private var userEmail: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            // Top Bar: Profile title and buttons
            HStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                
                // Settings Button
                Button(action: {
                    print("Settings tapped")
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                // Placeholder for Additional Button
                Button(action: {
                    print("Additional button tapped")
                }) {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding([.top, .horizontal])
            
            // User Info Section
            HStack {
                // User Icon
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    )
                
                // Email Display
                Text(userEmail)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
            }
            .padding(.horizontal)
            
            Spacer() // Pushes content to the top
            
            // Bottom Tab Bar
            HStack {
                Spacer()
                
                Button(action: {
                    print("Home tapped")
                }) {
                    VStack {
                        Image(systemName: "house.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.black)  // Added this
                        Text("Home")
                            .font(.caption)
                            .foregroundColor(.black)  // Added this
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("History tapped")
                }) {
                    VStack {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.black)  // Added this
                        Text("History")
                            .font(.caption)
                            .foregroundColor(.black)  // Added this
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("Workout tapped")
                }) {
                    VStack {
                        Image(systemName: "figure.run")
                            .font(.system(size: 24))
                            .foregroundColor(.black)  // Added this
                        Text("Workout")
                            .font(.caption)
                            .foregroundColor(.black)  // Added this
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("Profile tapped")
                }) {
                    VStack {
                        Image(systemName: "person.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.black)  // Added this
                        Text("Profile")
                            .font(.caption)
                            .foregroundColor(.black)  // Added this
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color.white)
            .shadow(radius: 2)
        }
        .onAppear() {
            getCurrentUserEmail()
        }
    }
    
    private func getCurrentUserEmail() {
        if let currentUser = Auth.auth().currentUser {
            userEmail = currentUser.email ?? "No email Found"
        } else {
            userEmail = "Not Signed in"
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
