//
//  GameScene.swift
//  Project26
//
//  Created by Daniel Gx on 25/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import SpriteKit
import CoreMotion

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case portal = 32
}

class GameScene: SKScene {
    
    // MARK: - Properties
    
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var motionManager: CMMotionManager!
    var scoreLabel: SKLabelNode!
    var isGameOver = false
    var level = 1
    var portalActive = true
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    // MARK: - Life Cycle
    
    override func didMove(to view: SKView) {
        loadBackground()
        loadLevel(atLevel: level)
        createPlayer()
        addScore()
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        
        #if targetEnvironment(simulator)
            if let currentTouch = lastTouchPosition {
                let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
                physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
            }
        #else
            if let accelerometerData = motionManager.accelerometerData {
                physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
            }
        #endif
    }
    
    //MARK: - Methods
    
    func addScore() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    func loadLevel(atLevel level: Int) {
        guard level <= 5 else { gameOver(); return }
        
        guard let levelURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else {
            fatalError("Couldn't find level1.txt in the app bundle.")
        }
        
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Couldn't load level1.txt from the app bundle.")
        }
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for(column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                switch letter {
                    
                case "x": loadWall(atPosition: position)
                case "v": loadVortex(atPosition: position)
                case "s": loadStar(atPosition: position)
                case "f": loadFinish(atPosition: position)
                case "p": loadPortal(atPosition: position)
                case " ": emptySpace()
                default: fatalError("Unknown level letter: \(letter)"); break
                    
                }
            }
        }
    }
    
    func loadWall(atPosition position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "block")
        node.name = "wall"
        node.position = position
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        node.physicsBody?.isDynamic = false
        addChild(node)
    }
    
    func loadVortex(atPosition position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "vortex")
        node.name = "vortex"
        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
    }
    
    func loadStar(atPosition position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "star")
        node.name = "star"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false

        node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    func loadFinish(atPosition position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "finish")
        node.name = "finish"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false

        node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    func loadPortal(atPosition position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "portal")
        node.name = "portal"
        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.portal.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
    }
    
    func emptySpace() { }
    
    func loadBackground() {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    
    func gameOver() {
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = "Game Over"
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: 768, y: 384)
        gameOverLabel.zPosition = 2
        addChild(scoreLabel)
        
        let finalScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        finalScoreLabel.text = "Final Score: \(score)"
        finalScoreLabel.horizontalAlignmentMode = .center
        finalScoreLabel.position = CGPoint(x: 768, y: 192)
        finalScoreLabel.zPosition = 2
        addChild(finalScoreLabel)
    }
}

// MARK: - Touches

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
}

// MARK: - ContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        
        switch node.name {
        case "vortex":
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(by: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        case "star":
            node.removeFromParent()
            score += 1
            
        case "portal":
            guard portalActive else { break }
            
            for currentNode in children {
                if currentNode.name == "portal" && currentNode != node {
                    enterPortalAction(portalIn: node, portalOut: currentNode)
                    break
                }
            }
            break
            
        case "finish":
            level += 1
            destroyLevel()
            loadLevel(atLevel: level)
            createPlayer()
            
        default: break
        }
    }
    
    func destroyLevel() {
        for node in children {
            if ["wall", "vortex", "star", "finish", "portal"].contains(node.name) {
                node.removeFromParent()
            }
        }
        player.removeFromParent()
    }
    
    func enterPortalAction(portalIn: SKNode, portalOut: SKNode) {
        player.physicsBody?.isDynamic = false
        
        let rotate = SKAction.rotate(byAngle: -.pi, duration: 0.1)
        let rotateSequence = SKAction.sequence([rotate, rotate, rotate, rotate, rotate])
        player.run(rotateSequence)
        
        let move = SKAction.move(to: portalIn.position, duration: 0.25)
        let fade = SKAction.fadeOut(withDuration: 0.25)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, fade, remove])
        
        player.run(sequence) { [weak self, weak portalOut] in
            if let portalOut = portalOut {
                self?.exitPortalAction(portalOut: portalOut)
            }
        }
    }
    
    func exitPortalAction(portalOut: SKNode) {
        createPlayer()
        player.alpha = 0.0
        player.position = portalOut.position

        let rotate = SKAction.rotate(byAngle: -.pi, duration: 0.05)
        let rotateSequence = SKAction.sequence([rotate, rotate, rotate, rotate, rotate])
        player.run(rotateSequence)

        player.run(SKAction.fadeIn(withDuration: 0.25))
        
        portalActive = false
    }
}
