//
//  PedestalView.swift
//  PromptReader2
//
//  Created by Monophotic on 2024/4/3.
//

import SwiftUI

struct PedestalView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.black.opacity(0.8))
            .blur(radius: 1)
            .frame(width: 960, height: 540)
           
    }
}

#Preview {
    PedestalView()
}
