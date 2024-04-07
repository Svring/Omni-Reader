//
//  ImageInfo.swift
//  PromptReader
//
//  Created by Monophotic on 2024/3/30.
//

import Foundation
import SwiftData

@Model
class ImageInfo {
    let generator: String
    let positivePrompt: String
    let negativePrompt: String
    let samplerName: String
    let step: Int
    let cfgScale: Int
    let seed: Int
    let modelName: String
    let modelHash: String
    let size: String
    let metadata: [String: String]
    let rawParams: [String: String]

    init(generator: String, positivePrompt: String, negativePrompt: String, samplerName: String, step: Int, cfgScale: Int, seed: Int, modelName: String, modelHash: String, size: String, metadata: [String: String], rawParams: [String: String]) {
        self.generator = generator
        self.positivePrompt = positivePrompt
        self.negativePrompt = negativePrompt
        self.samplerName = samplerName
        self.step = step
        self.cfgScale = cfgScale
        self.seed = seed
        self.modelName = modelName
        self.modelHash = modelHash
        self.size = size
        self.metadata = metadata
        self.rawParams = rawParams
    }
}
