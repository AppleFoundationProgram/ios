import SpriteKit

class ThrowScene: SKScene {
    
    private var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
    }
    
    func animateCircle(from direction: ThrowDirection, completion: @escaping () -> Void) {
        let texture = SKTexture(imageNamed: "crumpledPaper")
        
        let circleWidth: CGFloat = 100
        let aspectRatio = texture.size().width / texture.size().height
        let circleHeight = circleWidth / aspectRatio
        
        let circle = SKSpriteNode(texture: texture)
        circle.size = CGSize(width: circleWidth, height: circleHeight)
        circle.zPosition = 1 // zPosition 설정
        
        switch direction {
        case .right:
            circle.position = CGPoint(x: frame.maxX - circleWidth / 2, y: frame.minY + circleHeight / 2)
        case .left:
            circle.position = CGPoint(x: frame.minX + circleWidth / 2, y: frame.minY + circleHeight / 2)
        case .center:
            circle.position = CGPoint(x: frame.midX, y: frame.minY + circleHeight / 2)
        }
        
        addChild(circle)
        
        let path = UIBezierPath()
        path.move(to: circle.position)
        
        let destinationPoint = CGPoint(x: frame.midX + 30, y: frame.midY + 20)
        
        switch direction {
        case .right:
            path.addQuadCurve(to: destinationPoint,
                              controlPoint: CGPoint(x: frame.maxX - 100, y: frame.maxY - 100))
        case .left:
            path.addQuadCurve(to: destinationPoint,
                              controlPoint: CGPoint(x: frame.minX + 100, y: frame.maxY - 100))
        case .center:
            path.addQuadCurve(to: destinationPoint,
                              controlPoint: CGPoint(x: frame.midX, y: frame.maxY - 100))
        }
        
        let followPath = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, duration: 1.5)
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.55)
        let scaleDown = SKAction.scale(to: 0.7, duration: 0.55)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.removeFromParent()
        
        let group = SKAction.group([followPath, scaleSequence])
        let sequence = SKAction.sequence([group, fadeOut, remove])
        
        circle.run(sequence) {
            completion()
        }
    }
}
