//
//  WholeView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/3.
//

import SwiftUI
import SwiftData

struct WholeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var imageInfoes: [PromptInfo]
    @State private var imageInfo: PromptInfo?
    
    var body: some View {
        ZStack {
            PedestalView()
                
            HStack(spacing: 4) {
                SelectionView(imageInfoes: imageInfoes, imageInfo: $imageInfo)
                
                CenterView(imageInfo: $imageInfo)
                
                InfoView(imageInfo: imageInfo)
            }
        }
        .onAppear{
            do {
                try modelContext.delete(model: PromptInfo.self)
                for path in Bundle.main.paths(forResourcesOfType: nil, inDirectory: nil) {
                    print(path)
                }

            } catch {
                print("Failed to clear database.")
            }
        }
    }
}

#Preview {
    WholeView()
        .modelContainer(for: PromptInfo.self, inMemory: true)
}
