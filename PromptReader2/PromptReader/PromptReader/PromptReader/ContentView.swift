//
//  ContentView.swift
//  PromptReader
//
//  Created by Monophotic on 2024/3/29.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Query private var imageinfos: [ImageInfo]
    @Environment(\.modelContext) private var context

    @State private var selectedImage: NSImage?

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 320)
            }

            Button("Choose") {
                openImagePicker()
            }
        }
        .padding()
//        .onChange(of: avatarImage) {
//            Task {
//                let sys = Python.import("sys")
//                sys.path.append("/Users/linkling/main/Artificial/PromptReader/PromptReader/PromptReader/")
//                let sdparser = Python.import("Sdparser")
//                imageInfo = String(sdparser.parse())!
//            }
//        }
//        .onAppear {
//            let sys = Python.import("sys")
//            sys.path.append("/Users/linkling/main/Artificial/PromptReader/PromptReader/PromptReader/")
//            let sdparser = Python.import("Sdparser")
//            imageInfo = String(sdparser.parse())!
//        }
    }

    func openImagePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.jpeg, .png, .jpeg]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true

        if panel.runModal() == .OK {
            if let url = panel.url {
                selectedImage = NSImage(contentsOf: url)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ImageInfo.self, inMemory: true)
}
