//
//  Profile.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var name: String
    var icon: Int
    var maxScore: Int
    
    init(name: String, icon: Int, maxScore: Int) {
        self.name = name
        self.icon = icon
        self.maxScore = maxScore
    }
}
