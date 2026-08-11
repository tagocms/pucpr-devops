//
//  GameScene.swift
//  Pebbles Shared
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/26.
//

import SpriteKit

class GameScene: SKScene {
    fileprivate var label : SKLabelNode?
    fileprivate var ballNode : SKShapeNode?

    
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
        //
    }
    
    override func didMove(to view: SKView) {
        setUpScene()
    }
}

// Input handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
}

// Update
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
