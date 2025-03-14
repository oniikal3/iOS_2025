//
//  ContentView.swift
//  FirstImmersive
//
//  Created by Nathapong Masathien on 13/3/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State var enlarge = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })
            
            Button("Open Immersive Space") {
                Task {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                }
            }

            VStack {
                Button {
                    enlarge.toggle()
                } label: {
                    Text(enlarge ? "Reduce RealityView Content" : "Enlarge RealityView Content")
                }
                .animation(.none, value: 0)
                .fontWeight(.semibold)
//                Toggle("Change Size", isOn: $enlarge)
//                    .toggleStyle(.button)
            }
            .padding()
            .glassBackgroundEffect()
            
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
