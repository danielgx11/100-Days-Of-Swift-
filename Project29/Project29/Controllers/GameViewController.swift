//
//  GameViewController.swift
//  Project29
//
//  Created by Daniel Gx on 08/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
        
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerOneScore: UIButton!
    @IBOutlet weak var playerTwoScore: UIButton!
    
    var player1Score = 0 {
        didSet {
            playerOneScore.titleLabel?.text = "Player one: \(player1Score) points"
        }
    }
    var player2Score = 0 {
        didSet {
            playerTwoScore.titleLabel?.text = "Player two: \(player2Score) points"
        }
    }
    
    var chancesRemaining = 3
    var currentGame: GameScene!
    
    // MARK: - Actions
    
    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "Angle \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        angleChanged(angleSlider!)
        velocityChanged(velocitySlider!)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.gameViewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
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
    
    // MARK: - Methods
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
    func endGame() -> Bool {
        if chancesRemaining == 0 {
            let champion = bestPlayer()
            playerNumber.font = UIFont(name: "Chalkduster", size: 48)
            playerNumber.text = "Player \(champion) was champion"
            playerOneScore.isHidden = true
            playerTwoScore.isHidden = true
            launchButton.isHidden = true
            return true
        } else {
            return false
        }
    }
    
    func bestPlayer() -> String {
        if player1Score > player2Score {
            return "One"
        } else {
            return "Two"
        }
    }
}
