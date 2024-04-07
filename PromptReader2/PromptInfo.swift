//
//  ImageInfo.swift
//  PromptReader
//
//  Created by Monophotic on 2024/3/30.
//

import Foundation
import SwiftData

@Model
class PromptInfo: Codable {
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
    @Relationship(deleteRule: .cascade) var artwork: Artwork?
    let workflow: String?

    enum CodingKeys: String, CodingKey {
        case generator, positivePrompt, negativePrompt, samplerName, step, cfgScale, seed, modelName, modelHash, size, metadata, rawParams, workflow
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
        workflow = try container.decodeIfPresent(String.self, forKey: .workflow)
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
        try? container.encodeIfPresent(workflow, forKey: .workflow)
    }

    // New initializer for creating a dummy data object
    init() {
        generator = "AUTOMATIC1111"
        positivePrompt = "((masterpiece, best quality, ultra-detailed)), <lora:add_detail:0.5>,\n1girl, sit on the chair, cross legs"
        negativePrompt = "bad-image-v2-39000 verybadimagenegative_v1.3 bad_prompt_version2 EasyNegativeV2 bad-artist-anime"
        samplerName = "DPM++ 2M Karras"
        step = "20"
        cfgScale = "10"
        seed = "3859210100"
        modelName = "CounterfeitV30_v30"
        modelHash = "cbfba64e66"
        size = "512x768"
        metadata = ["size": "512x768", "clip_skip": "2", "adetailer_model": "face_yolov8n.pt", "adetailer_conf": "30", "adetailer_dilate/erode": "32", "adetailer_mask_blur": "4", "adetailer_denoising_strength": "0.4", "adetailer_inpaint_full": "True", "adetailer_inpaint_padding": "0", "adetailer_version": "23.5.19", "model": "None", "weight": "1", "starting/ending": "(0", "resize_mode": "Crop and Resize", "pixel_perfect": "False", "control_mode": "Balanced", "preprocessor_params": "(-1"]
        rawParams = ["parameters": "((masterpiece, best quality, ultra-detailed)), <lora:add_detail:0.5>,\n1girl, sit on the chair, cross legs\nNegative prompt: bad-image-v2-39000 verybadimagenegative_v1.3 bad_prompt_version2 EasyNegativeV2 bad-artist-anime\nSteps: 20, Sampler: DPM++ 2M Karras, CFG scale: 10, Seed: 3859210100, Size: 512x768, Model hash: cbfba64e66, Model: CounterfeitV30_v30, Clip skip: 2, ADetailer model: face_yolov8n.pt, ADetailer conf: 30, ADetailer dilate/erode: 32, ADetailer mask blur: 4, ADetailer denoising strength: 0.4, ADetailer inpaint full: True, ADetailer inpaint padding: 0, ADetailer version: 23.5.19, ControlNet 0: preprocessor: reference_only, model: None, weight: 1, starting/ending: (0, 1), resize mode: Crop and Resize, pixel perfect: False, control mode: Balanced, preprocessor params: (-1, 0.5, -1)"]
    }
}
