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
    fileprivate var otherBallNode : BallNode?
    fileprivate var playerID: Int = 0

    
    class func newGameScene(size: CGSize, newPlayerID: Int) -> GameScene {
        let scene = GameScene(size: size, newPlayerID: newPlayerID)
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        return scene
    }
    
    init(size: CGSize, newPlayerID: Int) {
        self.playerID = newPlayerID
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Scene initialization
extension GameScene {
    private func setUpScene() {
        let ballNode = BallNode(
            ellipseOf: CGSize(width: 20, height: 20),
            position: CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        )
        self.ballNode = ballNode
        self.ballNode?.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.addChild(ballNode)
        self.ballNode?.id = self.playerID
        
        let otherBallNode = BallNode(
            ellipseOf: CGSize(width: 20, height: 20),
            position: CGPoint(x: self.size.width / 2 + 30, y: self.size.height / 2 + 30)
        )
        otherBallNode.fillColor = .green
        otherBallNode.id = self.playerID == 1 ? 2 : 1
        self.otherBallNode = otherBallNode
        self.addChild(otherBallNode)
        
        var splinePoints = [
            CGPoint(x: 0, y: (self.size.height / 2) - 200),
            CGPoint(x: self.size.width, y: (self.size.height / 2) - 200)
        ]
        let ground = SKShapeNode(splinePoints: &splinePoints, count: splinePoints.count)
        ground.lineWidth = 5
        if let path = ground.path {
            ground.physicsBody = SKPhysicsBody(edgeChainFrom: path)
            ground.physicsBody?.restitution = 0.75
            ground.physicsBody?.isDynamic = false
        }
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
        self.ballNode?.update(currentTime, isHost: true)
        
        self.otherBallNode?.update(currentTime, isHost: false)
    }
}
