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
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Profile.self)
    }
    
    
    func customizeStyle() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .quizGreen
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.quizGreen.withAlphaComponent(0.2)
    }
    
    init() {
        customizeStyle()
    }
}
