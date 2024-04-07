//
//  PromptReaderApp.swift
//  PromptReader
//
//  Created by Monophotic on 2024/3/29.
//

import SwiftUI
import SwiftData

@main
struct PromptReaderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ImageInfo.self)
                .frame(minWidth: 400, minHeight: 600)
        }
    }
}
