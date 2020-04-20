//
//  MainViewController.swift
//  Project8
//
//  Created by Daniel Gx on 14/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var cluesLabel: UILabel = {
        let cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return cluesLabel
    }()
    var answersLabel: UILabel = {
        let answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return answersLabel
        }()
    var currentAnswer: UITextField = {
        let currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        return currentAnswer
    }()
    var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        return scoreLabel
    }()
    let submit: UIButton = {
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return submit
    }()
    let clear: UIButton = {
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return clear
    }()
    let buttonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var countSolutions = 0
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    // MARK: - Actions
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n") {
                didSet {
                    countSolutions += 1
                }
            }
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
                        
            if countSolutions == 7{
                alertController("Let's Go!", message: "Are you read for the next level?", upLevel: true)
            }
        } else {
            alertController("Warning", message: "You typed a incorrect guess, good luck and try again!")
            score -= 1
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(scoreLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
        view.addSubview(currentAnswer)
        view.addSubview(submit)
        view.addSubview(clear)
        view.addSubview(buttonsView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadLevel()
    }
    
    // MARK: - Methods
    
    func levelUp(action: UIAlertAction) {
        DispatchQueue.global().async {
            self.level += 1
            self.solutions.removeAll(keepingCapacity: true)
            
            self.loadLevel()
        }
        for btn in self.letterButtons {
            btn.isHidden = false
        }
        
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        DispatchQueue.global().async {
            if let levelFileURL = Bundle.main.url(forResource: "level\(self.level)", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]
                        
                        clueString += "\(index + 1). \(clue)\n"
                        
                        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                        solutionString += "\(solutionWord.count) letters\n"
                        self.solutions.append(solutionWord)
                        
                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            letterBits.shuffle()
            
            if letterBits.count == self.letterButtons.count {
                for i in 0 ..< self.letterButtons.count {
                    self.letterButtons[i].setTitle(letterBits[i], for: .normal)
                }
            }
        }
    }
    
    func alertController(_ title: String, message: String, upLevel: Bool = false) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if upLevel {
            ac.addAction(UIAlertAction(title: "Let's Go!", style: .default, handler: levelUp))
        } else {
            ac.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
        }
        present(ac, animated: true)
    }
}

// MARK: - UI Setup

extension MainViewController {
    private func setupUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        let widht = 150
        let height = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: col * widht, y: row * height, width: widht, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        
        NSLayoutConstraint.activate([scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     
                                     cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                                     cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                                     cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
                                     
                                     answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                                     answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                                     answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
                                     answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
                                     
                                     currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                                     currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
                                     
                                     submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
                                     submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
                                     submit.heightAnchor.constraint(equalToConstant: 44),
                                     
                                     clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
                                     clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
                                     clear.heightAnchor.constraint(equalToConstant: 44),
                                     
                                     buttonsView.widthAnchor.constraint(equalToConstant: 750),
                                     buttonsView.heightAnchor.constraint(equalToConstant: 320),
                                     buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
                                     buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
                                    ])
    }
}
