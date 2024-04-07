//
//  InfoView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/3.
//

import SwiftUI

struct InfoView: View {
    var imageInfo: PromptInfo?
    
    var body: some View {
        ScrollView {
            VStack {
                if let image = imageInfo {
                    InfoCardView(field: "Generator", content: image.generator)
                    
                    InfoCardView(field: "Model", content: image.modelName)
                    
                    InfoCardView(field: "Positive Prompt", content: image.positivePrompt)
                    
                    InfoCardView(field: "Negative Prompt", content: image.negativePrompt)
                    
                    InfoCardView(field: "Sampler", content: image.samplerName)
                    
                    HStack(spacing: 8) {
                        InfoCardView(field: "seed", content: image.seed)
                        InfoCardView(field: "Guidance", content: image.cfgScale)
                    }
                    
                    HStack(spacing: 8) {
                        InfoCardView(field: "steps", content: image.step)
                        InfoCardView(field: "size", content: image.size)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(width: 200)
        }
        .frame(maxHeight: 520)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    InfoView(imageInfo: PromptInfo())
}
