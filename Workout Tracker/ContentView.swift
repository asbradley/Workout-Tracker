//
//  ContentView.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/21/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift


struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var userIsLoggedIn: Bool = false
    @State private var navigateToProfile: Bool = false
    
    var body: some View {
        NavigationStack { 
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.red, .black]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    
                    
                    
                    
                    Button(action: {
                        // TODO: Add Google Sign-In action
                        
                        // THIS DOES NOT WORK NEEDS TO BE FIXED SOMEHOW
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let rootViewController = windowScene.windows.first?.rootViewController else {
                            print("No root view controller available.")
                            return
                        }

                        GIDSignIn.sharedInstance.signIn(
                            withPresenting: rootViewController
                        ) { result, error in
                            if let error = error {
                                print("Error signing in: \(error.localizedDescription)")
                                return
                            }

                            guard let user = result?.user else {
                                print("No user found.")
                                return
                            }

                            print("Signed in as: \(user.profile?.email ?? "No Email")")
                        }
                        
  
                        
                    }) {
                        HStack {
                            Image("Google Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 24)
                                .padding(.trailing, 8)
                            
                            Text("Continue with Google")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    .padding()
                    
                    HStack {
                        Rectangle()
                            .frame(width: 75, height: 2)
                            .foregroundColor(.white)
                        
                        Text("Or sign up with email")
                            .foregroundColor(Color.white)
                        
                        Rectangle()
                            .frame(width: 75, height: 2)
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading) {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom)
                    }
                    .padding()
                    
                    Button(action: {
                        register()
                    }) {
                        Text("Create Account")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(destination: LoginView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: BackButton())
                    ) {
                        Text("Already have an account?")
                            .foregroundColor(.white)
                            .underline()
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .padding()
            }
        }
        
        .fullScreenCover(isPresented: $navigateToProfile) {
            ProfileView()
        }
        
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    userIsLoggedIn.toggle()
                }
            }
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Account was created successfully!")
                
                navigateToProfile = true // TEMP
                
            }
        }
    }
}

// Create a custom back button component
struct BackButton: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
