//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/21/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct Workout_TrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    /*
    init() {
        FirebaseApp.configure()
    }
     */
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
