import SwiftUI
import SpriteKit

struct ThrowSceneView: UIViewRepresentable {
    let scene: ThrowScene

    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.backgroundColor = .clear
        skView.presentScene(scene)
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {
    }
}
