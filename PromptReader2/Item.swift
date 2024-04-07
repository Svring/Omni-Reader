//
//  Item.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/3/30.
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
