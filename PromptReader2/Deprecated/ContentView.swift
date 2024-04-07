//
//  ContentView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/3/30.
//

import Foundation
import PythonKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var imageInfoes: [PromptInfo]
    @State private var imageInfo: PromptInfo?

    @State private var showImagePanel: Bool = false

    @State private var hoveredId: PersistentIdentifier?
    @State private var sheetPresent = false

    @State private var imageUrl: String?
    @State private var uploadedImage: NSImage?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(imageInfoes) { image in
                    Button(action: {
                        withAnimation {
                            imageInfo = image
                            showImagePanel = true
                        }
                    }, label: {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .clipShape(.capsule)
                                .frame(maxWidth: 200, minHeight: 40)
                                .foregroundStyle(Color(red: 0.0, green: 0.0, blue: 0.3))
                                .background(.opacity(0))
                                .opacity(0.8)
                                .padding(EdgeInsets())
                            if image.artwork != nil {
                                Image(nsImage: NSImage(data: image.artwork!.artwork)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 180)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                            }
                        }
                        .overlay(
                            imageInfo == image ?
                                Capsule()
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 1)
                                : nil
                        )
                        .scaleEffect(hoveredId == image.id ? 1.1 : 1.0)
                        .onHover(perform: { hovering in
                            NSCursor.pointingHand.set()
                            withAnimation {
                                hoveredId = hovering ? image.id : nil
                            }
                        })
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .background(Color.black.opacity(0.1))
        } detail: {
            HStack(alignment: .bottom) {
                VStack {
                    if let image = imageInfo?.artwork {
                        Image(nsImage: NSImage(data: image.artwork)!)
                            .resizable()
                            .scaledToFit()
                    } else {
                        VStack(alignment: .center) {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                                .opacity(0.2)
                            Text("Drag Image here or click plus button above")
                                .font(.caption)
                                .opacity(0.6)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: openImagePicker) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: openImagePanel) {
                        Label("Open image panel", systemImage: "info.circle.fill")
                    }
                }
            }
            .inspector(isPresented: $showImagePanel) {
                if let info = imageInfo {
                    ImageDetailView(imageInfo: info)
                }
            }
            .navigationTitle("Prompt Reader")
            .background(Color(.black).opacity(0.5))
        }
        .onDrop(of: [.fileURL], isTargeted: nil, perform: { providers, _ in
            handleDrop(providers: providers)
        })
        .sheet(isPresented: $sheetPresent) {
            if let image = imageInfo {
                ComfyWebView(workflowData: image.workflow!)
                    .frame(width: 1000, height: 1000)
            }
        }
    }

    func openImagePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.jpeg, .png, .jpeg]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true

        if panel.runModal() == .OK {
            if let url = panel.url {
                uploadedImage = NSImage(contentsOf: url)
                parseImage(url: url)
            }
        }
    }

    func handleDrop(providers: [NSItemProvider]) -> Bool {
        for provider in providers {
            provider.loadItem(forTypeIdentifier: "public.file-url", options: nil) { urlData, _ in
                DispatchQueue.main.async {
                    if let urlData = urlData as? Data, let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL? {
                        if let image = NSImage(contentsOf: url) {
                            self.uploadedImage = image
                            parseImage(url: url)
                        }
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
                    if info.generator == "ComfyUI" {
                        sheetPresent = true
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        } else {
            print("Failed to convert JSON string to Data")
        }
    }

    func openImagePanel() {
        if imageInfo != nil {
            showImagePanel.toggle()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PromptInfo.self, inMemory: true)
}
