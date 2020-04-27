//
//  GameScene.swift
//  Project11
//
//  Created by Daniel Gx on 27/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Life Cycle
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        for index in 0..<5 {
            let xPoint = index * 256
            makeBouncer(at: CGPoint(x: xPoint, y: 0))
        }
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let ball = SKSpriteNode(imageNamed: "ballRed")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2.0)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - Methods
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = CGPoint(x: position.x, y: position.y)
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
}
