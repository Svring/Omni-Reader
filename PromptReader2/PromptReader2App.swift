//
//  PromptReader2App.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/3/30.
//

import SwiftData
import SwiftUI

@main
struct PromptReader2App: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PromptInfo.self,
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
//            ContentView()
//                .frame(minWidth: 500, minHeight: 600)
            WholeView()
                .frame(width: 960, height: 540)
        }
        .modelContainer(sharedModelContainer)
    }
    
}
