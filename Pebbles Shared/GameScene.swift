//
//  GameScene.swift
//  Pebbles Shared
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/26.
//

import SpriteKit

class GameScene: SKScene {
    fileprivate var label : SKLabelNode?
    fileprivate var ballNode : BallNode?

    
    class func newGameScene(size: CGSize) -> GameScene {
        let scene = GameScene(size: size)
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        return scene
    }
}

// Scene initialization
extension GameScene {
    private func setUpScene() {
//        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        let ballNode = BallNode(
            ellipseOf: CGSize(width: 20, height: 20),
            position: CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        )
        self.ballNode = ballNode
        self.ballNode?.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.addChild(ballNode)
        
        var splinePoints = [
            CGPoint(x: 0, y: (self.size.height / 2) - 200),
            CGPoint(x: self.size.width, y: (self.size.height / 2) - 200)
        ]
        let ground = SKShapeNode(splinePoints: &splinePoints, count: splinePoints.count)
        ground.lineWidth = 5
        ground.physicsBody = SKPhysicsBody(edgeChainFrom: ground.path!)
        ground.physicsBody?.restitution = 0.75
        ground.physicsBody?.isDynamic = false
        self.addChild(ground)
    }
    
    override func didMove(to view: SKView) {
        setUpScene()
    }
}

// Input handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            self.ballNode?.physicsBody?.applyImpulse(.init(dx: 0, dy: 10))
        }
    }
}

// Update
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.ballNode?.update(currentTime)
    }
}
