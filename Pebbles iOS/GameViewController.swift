//
//  GameViewController.swift
//  Pebbles iOS
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/26.
//

import GameplayKit
import SpriteKit
import SwiftUI
import UIKit
internal import Combine

class GameViewController: UIViewController {
    private var playerModel: PlayerModel = PlayerModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: view.bounds)
        
        let menuView = MenuView(playerModel: playerModel)
        let controller = UIHostingController(rootView: menuView)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
                    controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
                    controller.view.heightAnchor.constraint(equalTo: view.heightAnchor),
                    controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
        
        playerModel.$id.sink { id in
            print("Alterou o ID: \(id)")
            if id == 1 || id == 2 {
                controller.removeFromParent()
                controller.view.removeFromSuperview()
                // Present the scene
                let skView = self.view as! SKView
                let scene = GameScene.newGameScene(size: skView.bounds.size, newPlayerID: id)
                skView.presentScene(scene)
            }
        }.store(in: &cancellables)
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
