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
                .addKeyboardVisibilityToEnvironment()
        }
        .modelContainer(for: Profile.self)
    }
}
