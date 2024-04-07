//
//  Extensions.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/2.
//

import AppKit
import Foundation

public extension NSImage {
    /// Returns the PNG data for the `NSImage` as a Data object.
    ///
    /// - Returns: A data object containing the PNG data for the image, or nil
    /// in the event of failure.
    ///
    func pngData() -> Data? {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }

        let bitmapRepresentation = NSBitmapImageRep(cgImage: cgImage)
        return bitmapRepresentation.representation(using: .png, properties: [:])
    }
}
