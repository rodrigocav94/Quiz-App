//
//  Quiz_AppApp.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import SwiftUI
import SwiftData

@main
struct Quiz_AppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
    
    
    func customizeStyle() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .quizGreen
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.quizGreen.withAlphaComponent(0.2)
    }
    
    init() {
        customizeStyle()
    }
}
