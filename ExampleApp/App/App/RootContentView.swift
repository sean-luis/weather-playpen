//
//  RootContentView.swift
//  App
//
//  Created by Sean Gomes-Luis on 2025/08/21.
//

import SwiftUI

struct RootContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RootContentView()
}
