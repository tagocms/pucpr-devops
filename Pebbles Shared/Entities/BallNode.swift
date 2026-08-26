//
//  BallNode.swift
//  Pebbles iOS
//
//  Created by Tiago Camargo Maciel dos Santos on 11/08/26.
//

import Foundation
import SpriteKit

class BallNode: SKShapeNode {
    var id: Int
    
    init(id: Int = 1, ellipseOf size: CGSize, position: CGPoint) {
        self.id = id
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
    func update(_ currentTime: TimeInterval, isHost: Bool) {
        switch isHost {
        case true:
            sendCurrentPosition()
        case false:
            updateCurrentPosition()
        }
    }
}

extension BallNode {
    static let serverURL: URL = URL(string: "http://localhost:8080")!
    
    func sendCurrentPosition() {
        let dictionaryData: [String: CGFloat] = [
            "x": self.position.x,
            "y": self.position.y
        ]
        guard let encodedData = try? JSONEncoder().encode(dictionaryData) else {
            return
        }
        
        let newURL = URL(string: "position/\(id)", relativeTo: Self.serverURL)!
        var urlRequest = URLRequest(url: newURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = encodedData
        
        Task {
            do {
                let (_, response) = try await URLSession.shared.data(for: urlRequest)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func updateCurrentPosition() {
        let newURL = URL(string: "position/\(id)", relativeTo: Self.serverURL)!
        var urlRequest = URLRequest(url: newURL)
        urlRequest.httpMethod = "GET"
        
        Task { @MainActor in
            do {
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                
                guard let decodedData = try? JSONDecoder().decode([String: CGFloat].self, from: data) else {
                    return
                }
                print(decodedData)
                
                self.position.x = CGFloat(decodedData["x"]!)
                self.position.y = CGFloat(decodedData["y"]!)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
