//
//  Profile.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import Foundation
import SwiftData

@Model
final class Profile: Codable {
    enum CodingKeys: CodingKey {
        case id, name, icon, maxScore
    }
    var id = UUID()
    var name: String
    var icon: Int
    var maxScore: Int
    
    init(name: String, icon: Int, maxScore: Int) {
        self.name = name
        self.icon = icon
        self.maxScore = maxScore
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode(Int.self, forKey: .icon)
        maxScore = try container.decode(Int.self, forKey: .maxScore)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(icon, forKey: .icon)
        try container.encode(maxScore, forKey: .maxScore)
    }
}
