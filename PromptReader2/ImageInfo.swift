//
//  ImageInfo.swift
//  PromptReader
//
//  Created by Monophotic on 2024/3/30.
//

import Foundation
import SwiftData

@Model
class ImageInfo: Codable {
    let generator: String
    let positivePrompt: String
    let negativePrompt: String
    let samplerName: String
    let step: String
    let cfgScale: String
    let seed: String
    let modelName: String
    let modelHash: String
    let size: String
    let metadata: [String: String]
    let rawParams: [String: String]

    enum CodingKeys: String, CodingKey {
        case generator, positivePrompt, negativePrompt, samplerName, step, cfgScale, seed, modelName, modelHash, size, metadata, rawParams
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        generator = try container.decode(String.self, forKey: .generator)
        positivePrompt = try container.decode(String.self, forKey: .positivePrompt)
        negativePrompt = try container.decode(String.self, forKey: .negativePrompt)
        samplerName = try container.decode(String.self, forKey: .samplerName)
        step = try container.decode(String.self, forKey: .step)
        cfgScale = try container.decode(String.self, forKey: .cfgScale)
        seed = try container.decode(String.self, forKey: .seed)
        modelName = try container.decode(String.self, forKey: .modelName)
        modelHash = try container.decode(String.self, forKey: .modelHash)
        size = try container.decode(String.self, forKey: .size)
        metadata = try container.decode([String: String].self, forKey: .metadata)
        rawParams = try container.decode([String: String].self, forKey: .rawParams)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(generator, forKey: .generator)
        try container.encode(positivePrompt, forKey: .positivePrompt)
        try container.encode(negativePrompt, forKey: .negativePrompt)
        try container.encode(samplerName, forKey: .samplerName)
        try container.encode(step, forKey: .step)
        try container.encode(cfgScale, forKey: .cfgScale)
        try container.encode(seed, forKey: .seed)
        try container.encode(modelName, forKey: .modelName)
        try container.encode(modelHash, forKey: .modelHash)
        try container.encode(size, forKey: .size)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(rawParams, forKey: .rawParams)
    }
}
