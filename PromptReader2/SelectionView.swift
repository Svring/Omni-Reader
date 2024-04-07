//
//  SelectionView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/3.
//

import SwiftData
import SwiftUI

struct SelectionView: View {
    var imageInfoes: [PromptInfo]
    @Binding var imageInfo: PromptInfo?
    @State private var hoveredId: PersistentIdentifier?
    
    var body: some View {
        VStack(spacing: 8) {
            List {
                ForEach(imageInfoes) { image in
                    if image.artwork != nil {
                        Button(action: {
                            imageInfo = image
                        }, label: {
                            Image(nsImage: NSImage(data: image.artwork!.artwork)!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                                .overlay(
                                    imageInfo == image ?
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                                        : nil
                                )
                                .scaleEffect(hoveredId == image.id ? 1.05 : 1.0)
                                .zIndex(hoveredId == image.id ? 1 : 0)
                                .onHover(perform: { hovering in
                                    NSCursor.pointingHand.set()
                                    withAnimation {
                                        hoveredId = hovering ? image.id : nil
                                    }
                                })
                                .padding([.top, .bottom])
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .frame(width: 200, height: 520)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
        .blur(radius: 0.5)
    }
}
