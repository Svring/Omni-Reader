//
//  InfoCardView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/6.
//

import SwiftUI

struct InfoCardView: View {
    var field: String
    var content: String
    var switchType = false
    @State private var isHovered = false
    @State private var show = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
                .blur(radius: 1)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .overlay {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .stroke(Color.white.opacity(0.3))
                }

            VStack(alignment: .leading) {
                Text(field)
                    .font(.caption)
                    .foregroundStyle(Color.white.opacity(0.6))

                Text(content)
                    .onTapGesture {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(content, forType: .string)
                    }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(isHovered ? .gray.opacity(0.4) : .gray.opacity(0.2))
        .onHover(perform: { hovering in
            NSCursor.pointingHand.set()
            isHovered = hovering
        })
    }
}

#Preview {
    InfoCardView(field: "Dummy Field", content: "Dummy Content")
}
