//
//  MainViewController.swift
//  Project02
//
//  Created by Daniel Gx on 26/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: MainCoordinator?
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var plays = 0
    
    var scoreButton: UIBarButtonItem!
    var playsButton: UIBarButtonItem!
    
    // MARK: - Outlets
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    // MARK: - Actions button
    
    @IBAction func firstButton(_ sender: UIButton) {
        var title: String
        var message: String
        
        plays += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            message = "Your score is \(score)"
        }
        
        allertController(title: title, message: message, to: true)
    }
    

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askQuestion()
    }
    
    // MARK: - Funcs
    
    func allertController(title: String, message: String, to go: Bool = false) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if go {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        } else {
            ac.addAction(UIAlertAction(title: "Exit", style: .default, handler: nil))
        }
        present(ac, animated: true)
    }
    
    func setContries() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "russia", "us", "uk"]
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        setContries()
        correctAnswer = Int.random(in: 0...2)
        navigationItem.title = countries[correctAnswer].uppercased()
        scoreButton = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: self, action: #selector(MainViewController.scoreTapped(_:)))
        playsButton = UIBarButtonItem(title: "Plays: \(plays)", style: .plain, target: self, action: #selector(MainViewController.playsTapped(_:)))
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = playsButton
        navigationItem.rightBarButtonItem = scoreButton
    }
    
    @objc func scoreTapped(_ sender: UIBarButtonItem!) {
        allertController(title: "Score", message: "Your score is \(score)")
    }
    
    @objc func playsTapped(_ sender: UIBarButtonItem!) {
        allertController(title: "Plays", message: "You played \(plays) times")
    }
}
