//
//  ImageDetailView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/3/31.
//

import SwiftUI
import UniformTypeIdentifiers

struct ImageDetailView: View {
    var imageInfo: PromptInfo
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Text("Generator")
                    .font(.custom("Athelas", size: 24))
                    .foregroundStyle(.gray)
                Text(imageInfo.generator)
                    .font(.custom("Athelas", size: 16))
            }
            
            VStack {
                Text("Model")
                    .foregroundStyle(.gray)
                Text(imageInfo.modelName)
            }
            
            VStack {
                Text("Positive Prompt")
                    .foregroundStyle(.gray)
                Text(imageInfo.positivePrompt)
            }
            
            VStack {
                Text("Negative Prompt")
                    .foregroundStyle(.gray)
                Text(imageInfo.negativePrompt)
            }
            
            HStack(spacing: 8) {
                VStack {
                    Text("Steps")
                        .foregroundStyle(.gray)
                    Text(imageInfo.step)
                }
                VStack {
                    Text("Guidance")
                        .foregroundStyle(.gray)
                    Text(imageInfo.cfgScale)
                }
                VStack {
                    Text("Seed")
                        .foregroundStyle(.gray)
                    Text(imageInfo.seed)
                }
                VStack {
                    Text("Sampler")
                        .foregroundStyle(.gray)
                    Text(imageInfo.samplerName)
                }
            }
            .font(.custom("Athelas", size: 10))
        }
        .frame(minWidth: 200, maxWidth: 250, minHeight: 600)
        .padding()
        .background(Color(red: 0.0, green: 0.0, blue: 0.15))
        .font(.custom("Athelas", size: 14))
        .textSelection(.enabled)
    }
}

#Preview {
    ImageDetailView(imageInfo: PromptInfo.init())
}
