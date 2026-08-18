//
//  PebblesTests.swift
//  PebblesTests
//
//  Created by Tiago Camargo Maciel dos Santos on 18/08/26.
//

import SpriteKit
import Testing
import UIKit

@testable import Pebbles

@Suite("GameScene tests")
struct GameSceneTests {
    @Test func `ball and ground nodes exist after setupScene called`() async throws {
        let vc = await GameViewController()
        let gameScene = await GameScene.newGameScene(size: vc.view.bounds.size)
        
        #expect(await gameScene.children.isEmpty == true)
        await gameScene.didMove(to: .init())
        #expect(await gameScene.children.isEmpty == false)
    }

}
