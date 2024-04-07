//
//  Image.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/1.
//

import Foundation
import SwiftData
import AppKit

@Model
class Artwork {
    
    var id: UUID // optionally add some other fields if needed
    @Attribute(.externalStorage) var artwork: Data
    
    init(artwork: Data) {
        self.id = UUID()
        self.artwork = artwork
    }
}
