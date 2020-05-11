//
//  WhackSlot.swift
//  Project14
//
//  Created by Daniel Gx on 08/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    
    // MARK: - Properties
    
    var isVisible = false
    var isHit = false
    var charNode: SKSpriteNode!
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    // MARK: - Methods
    
    func hit() {
        
        if let smokeParticle = SKEmitterNode(fileNamed: "Smoke") {
            smokeParticle.position = charNode.position
            
            let smokeSequence = SKAction.sequence( [
                SKAction.run({ [weak self] in
                self?.addChild(smokeParticle)}),
                SKAction.wait(forDuration: 1.5),
                SKAction.run(smokeParticle.removeFromParent)
                                                    ])
            run(smokeSequence)
        }
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        charNode.run(SKAction.sequence([delay, hide, notVisible]))
    }
    
    func show(hideTime: Double) {
        guard !isVisible else { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        guard isVisible else { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
}
