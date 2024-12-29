//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by Aidan Bradley on 12/21/24.
//

import SwiftUI
import Firebase


@main
struct Workout_TrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
