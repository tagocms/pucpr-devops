//
//  BallNode.swift
//  Pebbles iOS
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/26.
//

import SpriteKit
import UIKit

class BallNode: SKShapeNode {
    public var newPosition: CGPoint
    
    init(ellipseOf size: CGSize, position: CGPoint) {
        self.newPosition = position
        super.init()
        
        let rect = CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size)
        self.path = CGPath(ellipseIn: rect, transform: nil)
        self.fillColor = .red
        self.strokeColor = .white
        self.lineWidth = 2
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BallNode {
    func update(_ currentTime: TimeInterval) {
        self.position = newPosition
    }
}
