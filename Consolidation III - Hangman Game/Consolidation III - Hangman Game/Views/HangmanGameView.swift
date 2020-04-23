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
    var characterButtons = [UIButton]()
    let allLetters = (65...90).map {String(UnicodeScalar($0))}
        func randomLetter() -> String {
            return allLetters.randomElement()!
    }
    var activatedButtons = [UIButton]()
    var solution = String()
    var usedLetters = String()
    var errorsCount = 0 {
        didSet {
            self.errorsNavigationItem.title = "Errors: \(self.errorsCount)"
        }
    }
    var chancesRemaining = 6 {
        didSet {
            self.navigationItem.title = "Chances Remaining: \(self.chancesRemaining)"
            if self.chancesRemaining == 0 {
                alertController("Ops", message: "Looks like your chances are gone, good luck and try again.", lose: true)
            }
        }
    }
    
    let buttonsView: UIView = {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()

    var scoreNavigationItem: UIBarButtonItem = {
        let scoreNavigationItem = UIBarButtonItem()
        scoreNavigationItem.title = "Score: 0"
        scoreNavigationItem.tintColor = .black
        return scoreNavigationItem
    }()
    var errorsNavigationItem: UIBarButtonItem = {
        let errorsNavigationItem = UIBarButtonItem()
        errorsNavigationItem.title = "Errors: 0"
        errorsNavigationItem.tintColor = .black
        return errorsNavigationItem
    }()
    var score = 0 {
        didSet {
            self.scoreNavigationItem.title = "Score: \(self.score)"
        }
    }
    
    var correctAnswer: UITextField = {
        let correctAnswer = UITextField()
        correctAnswer.isUserInteractionEnabled = false
        correctAnswer.backgroundColor = .systemGray6
        correctAnswer.translatesAutoresizingMaskIntoConstraints = false
        correctAnswer.textAlignment = .center
        return correctAnswer
    }()
    
    var currentAnswer: UITextField = {
        let currentAnswer = UITextField()
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.layer.borderWidth = 2
        currentAnswer.layer.borderColor = UIColor(white: 3, alpha: 0.3).cgColor
        currentAnswer.placeholder = "Tap letter to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        return currentAnswer
    }()
    
    var submit: UIButton = {
        var submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.tintColor = .darkText
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return submit
    }()
    
    var clear: UIButton = {
        var clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.tintColor = .darkText
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return clear
    }()
    
    // MARK: - Actions
    
    func userLose() {
        chancesRemaining = 6
        settingPortugueseWord()
    }
    
    func userWin() {
        chancesRemaining = 6
        alertController("Congrats", message: "Very well, you wined that task and can advanced to next word, good luck! ")
        settingPortugueseWord()
    }
    
    @objc func characterTapped(_ sender: UIButton) {
        guard let characterTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(characterTitle)
        activatedButtons.append(sender)
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        
        let word = solution.lowercased()
        let usedWord = String((currentAnswer.text?.first?.lowercased())!)
        var promptWord = correctAnswer.text!
        var nextReplies = ""
        
        if word.contains(usedWord) {
            score += 1
        } else {
            chancesRemaining -= 1
            errorsCount += 1
            score -= 1
        }
        
        for (index, letter) in word.enumerated() {
            let strLetter = String(letter)
            if strLetter.contains(usedWord) {
                nextReplies += strLetter
                promptWord.remove(at: promptWord.index(promptWord.startIndex, offsetBy: index))
                promptWord.insert(letter, at: promptWord.index(promptWord.startIndex, offsetBy: index))
                correctAnswer.text = promptWord.uppercased()
            } else {
                continue
            }
        }
        currentAnswer.text?.removeAll()
        
        if promptWord.lowercased() == solution.lowercased() {
            userWin()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        recoverWords(language: "Profissões")
        customizeNavigationController()
        settingPortugueseWord()
    }
    
    // MARK: - Methods
    
    func alertController(_ title: String, message: String, lose: Bool = false) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if lose {
            ac.addAction(UIAlertAction(title: "try again!", style: .default, handler: { [weak self] (_) in
                self?.userLose()
            }))
        } else {
            ac.addAction(UIAlertAction(title: "Let's go", style: .cancel, handler: nil))
        }
        present(ac, animated: true)
    }
    
    func settingEnglishWord() {
        let randomIndex = arc4random()
        let word = allWordsEnglish[randomIndex.hashValue]
        correctAnswer.text = word
    }
    
    func settingPortugueseWord() {
        var promptWord = ""
        let randomIndex = Int.random(in: 1...99)
        let word = allWordsPortuguese[randomIndex]
        usedLetters = correctAnswer.text!
        correctAnswer.text = word
        solution = word

        for _ in word {
            promptWord += "?"
            correctAnswer.text = promptWord
        }
    }
    
    func recoverWords(language path: String) {
        DispatchQueue.global().async { [weak self] in
            if let hangmanWordsURL = Bundle.main.url(forResource: path, withExtension: "txt") {
                if let hangmanWords = try? String(contentsOf: hangmanWordsURL) {
                    if path == "Jobs" {
                        self?.allWordsEnglish = hangmanWords.components(separatedBy: "\n")
                        self?.allWordsEnglish.shuffle()
                    } else if path == "Profissões" {
                        self?.allWordsPortuguese = hangmanWords.components(separatedBy: "\n")
                        self?.allWordsPortuguese.shuffle()
                    }
                }
            } else {
                debugPrint("Recover words failed...")
            }
        }
    }
    
    func customizeNavigationController() {
        navigationItem.leftBarButtonItem = scoreNavigationItem
        navigationItem.title = "Chances Remaining: \(chancesRemaining)"
        navigationItem.rightBarButtonItem = errorsNavigationItem
        navigationController?.navigationBar.barTintColor = .systemPink
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
        
        /// Buttons activate
        
        let widht = 80
        let height = 40
        
        var index = 0
        
        for row in 0..<5 {
            for col in 0..<5 {
                let characterButton = UIButton(type: .system)
                characterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                characterButton.tintColor = .darkText
                characterButton.setTitle(allLetters[index], for: .normal)
                characterButton.addTarget(self, action: #selector(characterTapped), for: .touchUpInside)
                characterButton.backgroundColor = .gray
                characterButton.layer.borderWidth = 2
                characterButton.layer.borderColor = UIColor(white: 2, alpha: 0.3).cgColor
                characterButton.layer.cornerRadius = 20
                
                let frame = CGRect(x: col * widht, y: row * height, width: widht, height: height)
                debugPrint(frame)
                characterButton.frame = frame
                
                buttonsView.addSubview(characterButton)
                characterButtons.append(characterButton)
                index += 1
            }
        }
        let zButton = UIButton(type: .system)
        zButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        zButton.tintColor = .darkText
        zButton.backgroundColor = .gray
        zButton.layer.borderWidth = 2
        zButton.layer.borderColor = UIColor(white: 2, alpha: 0.3).cgColor
        zButton.layer.cornerRadius = 20
        zButton.setTitle("Z", for: .normal)
        zButton.addTarget(self, action: #selector(characterTapped), for: .touchUpInside)
        let frame = CGRect(x: 2 * widht, y: 5 * height, width: widht, height: height)
        debugPrint(frame)
        zButton.frame = frame
        buttonsView.addSubview(zButton)
    }
}
