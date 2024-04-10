//
//  CenterView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/3.
//

import PythonKit
import SwiftUI

struct CenterView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var imageUrl: URL?
    @Binding var imageInfo: PromptInfo?
    @State private var isHovered = false
    @State private var showSheetState = false

    var body: some View {
        ZStack {
            if let image = imageInfo {
                Image(nsImage: NSImage(data: image.artwork!.artwork)!)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    .scaledToFit()
            } else {
                VStack(alignment: .center) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.2)
                    Text("Click or Drag Image Here")
                        .font(.caption)
                        .opacity(0.6)
                }
            }
        }
        .frame(width: 440, height: 530)
        .background(isHovered ? .gray.opacity(0.3) : .gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
        .onChange(of: imageUrl) {
            parseImage(url: imageUrl!)
        }
        .onChange(of: imageInfo) {
            showSheetState = imageInfo?.generator == "ComfyUI"
        }
        .onDrop(of: [.fileURL], isTargeted: nil, perform: { providers, _ in
            handleDrop(providers: providers)
        })
        .onTapGesture {
            openImagePicker()
        }
        .onHover(perform: { hovering in
            NSCursor.pointingHand.set()
            isHovered = hovering
        })
        .sheet(isPresented: $showSheetState, content: {
            VStack {
                Button("Dismiss") {
                    showSheetState = false
                }
                WebView()
                    .frame(width: 1024, height: 720)
            }
        })
    }

    func openImagePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.jpeg, .png, .jpeg]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true

        if panel.runModal() == .OK {
            if let url = panel.url {
                imageUrl = url
            }
        }
    }

    func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { urlData, _ in
                DispatchQueue.main.async {
                    if let urlData = urlData as? Data, let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL? {
                        imageUrl = url
                    }
                }
            }
        }
        return true
    }

    func parseImage(url: URL) {
        let sys = Python.import("sys")
        let scriptPath = "/Users/linkling/main/Artificial/PromptReader2/PromptReader2/PythonScripts/"
        sys.path.append(scriptPath)
        let parser = Python.import("Sdparser")
        let prompt = String(parser.parse(url.path))!
        if let jsonData = prompt.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                imageInfo = try decoder.decode(PromptInfo.self, from: jsonData)
                if let info = imageInfo {
                    let imageData = NSImage(contentsOf: url)?.pngData()
                    info.artwork = Artwork(artwork: imageData!)
                    modelContext.insert(info)
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        } else {
            print("Failed to convert JSON string to Data")
        }
    }
}
