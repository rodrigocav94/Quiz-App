//
//  Item.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
