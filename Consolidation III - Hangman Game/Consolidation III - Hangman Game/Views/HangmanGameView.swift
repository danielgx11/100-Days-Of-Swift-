//
//  HangmanGameView.swift
//  Consolidation III - Hangman Game
//
//  Created by Daniel Gx on 21/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class HangmanGameView: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: HangmanFlow?
    var allWordsEnglish = [String]()
    var allWordsPortuguese = [String]()
    var usedEnglishWords = [String]()
    var usedPortugueseWords = [String]()
    
    let buttonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.backgroundColor = .red
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()

    var scoreNavigationItem: UIBarButtonItem = {
        let scoreNavigationItem = UIBarButtonItem()
        scoreNavigationItem.title = "Score: 0"
        scoreNavigationItem.tintColor = .black
        return scoreNavigationItem
    }()
    var score = 0 {
        didSet {
            self.scoreNavigationItem.title = "Score: \(self.score)"
        }
    }
    
    var correctAnswer: UITextField = {
        let correctAnswer = UITextField()
        correctAnswer.insertText("Resposta")
        correctAnswer.isUserInteractionEnabled = false
        correctAnswer.backgroundColor = .yellow
        correctAnswer.translatesAutoresizingMaskIntoConstraints = false
        correctAnswer.textAlignment = .center
        return correctAnswer
    }()
    
    var currentAnswer: UITextField = {
        let currentAnswer = UITextField()
        currentAnswer.text = "Tentativa"
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.backgroundColor = .green
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letter to guess"
        currentAnswer.textAlignment = .center
        return currentAnswer
    }()
    
    var submit: UIButton = {
        var submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        return submit
    }()
    
    var clear: UIButton = {
        var clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        return clear
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        recoverWords(language: "Profissões")
        customizeNavigationController()
    }
    
    // MARK: - Methods
    
    func recoverWords(language path: String) {
        DispatchQueue.global().async { [weak self] in
            if let hangmanWordsURL = Bundle.main.url(forResource: path, withExtension: "txt") {
                if let hangmanWords = try? String(contentsOf: hangmanWordsURL) {
                    if path == "Jobs" {
                        self?.allWordsEnglish = hangmanWords.components(separatedBy: "\n")
                    } else if path == "Profissões" {
                        self?.allWordsPortuguese = hangmanWords.components(separatedBy: "\n")
                    }
                }
            } else {
                debugPrint("Recover words failed...")
            }
        }
    }
    
    func customizeNavigationController() {
        navigationItem.leftBarButtonItem = scoreNavigationItem
    }
    
}

// MARK: - UI Setup

extension HangmanGameView {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    
        self.view.backgroundColor = .white
        self.view.addSubview(buttonsView)
        self.view.addSubview(correctAnswer)
        self.view.addSubview(currentAnswer)
        self.view.addSubview(submit)
        self.view.addSubview(clear)
        
        //TODO: Constraints
        correctAnswer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        correctAnswer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        correctAnswer.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
        correctAnswer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        currentAnswer.topAnchor.constraint(equalTo: correctAnswer.bottomAnchor, constant: 8).isActive = true
        currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentAnswer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        currentAnswer.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.10).isActive = true
        
        submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor).isActive = true
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        clear.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor).isActive = true
        clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100).isActive = true
        clear.heightAnchor.constraint(equalTo: submit.heightAnchor).isActive = true
        
        buttonsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
    }
}
