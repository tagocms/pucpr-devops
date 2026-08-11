//
//  GameViewController.swift
//  Pebbles iOS
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/26.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: view.bounds)

        // Present the scene
        let skView = self.view as! SKView
        let scene = GameScene.newGameScene(size: skView.bounds.size)
        skView.presentScene(scene)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
