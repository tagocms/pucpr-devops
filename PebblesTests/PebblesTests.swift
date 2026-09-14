//
//  PebblesTests.swift
//  PebblesTests
//
//  Created by Tiago Camargo Maciel dos Santos on 18/08/26.
//

import SpriteKit
import SwiftUI
import Testing
import UIKit

@testable import Pebbles

@Suite("GameScene tests")
struct GameSceneTests {
    @Test func `balls and ground nodes exist after setupScene called`() async throws {
        let vc = await GameViewController()
        let gameScene = await GameScene.newGameScene(size: vc.view.bounds.size, newPlayerID: 1)
        
        #expect(await gameScene.children.isEmpty == true)
        await gameScene.didMove(to: .init())
        #expect(await gameScene.children.isEmpty == false)
    }
    
    @Test func `there are exactly two ball nodes after setupScene called`() async throws {
        let vc = await GameViewController()
        let gameScene = await GameScene.newGameScene(size: vc.view.bounds.size, newPlayerID: 1)
        
        #expect(await gameScene.children.isEmpty == true)
        await gameScene.didMove(to: .init())
        
        var ballCount: Int = 0
        await gameScene.children.forEach { child in
            if child is Pebbles.BallNode {
                ballCount += 1
            }
        }
        #expect(ballCount == 2)
    }
    
    @Test func `first BallNode has physics body, but second doesn't`() async throws {
        let vc = await GameViewController()
        let gameScene = await GameScene.newGameScene(size: vc.view.bounds.size, newPlayerID: 1)
        
        #expect(await gameScene.children.isEmpty == true)
        await gameScene.didMove(to: .init())
        
        let firstBall = await gameScene.physicsWorld.body(at: CGPoint(x: gameScene.size.width / 2, y: gameScene.size.height / 2))
        let secondBall = await gameScene.physicsWorld.body(at: CGPoint(x: gameScene.size.width / 2 + 30, y: gameScene.size.height / 2))
        
        #expect(firstBall != nil && secondBall == nil)
        
    }

}

@Suite("GameViewController tests")
struct GameViewControllerTests {
    @Test func `GameViewController is initialized with a SKView in viewDidLoad()`() async throws {
        let vc = await GameViewController()
        await vc.viewDidLoad()
        
        #expect(vc.view is SKView)
    }
    
    @Test func `GameViewController has a UIHostingViewController as a child after viewDidLoad()`() async throws {
        let vc = await GameViewController()
        await vc.viewDidLoad()
        
        var hasUIHostingViewController: Bool = false
        await vc.children.forEach { child in
            if child is UIHostingController<MenuView> {
                hasUIHostingViewController = true
            }
        }
        
        #expect(hasUIHostingViewController == true)
    }
}
