//
//  DetailView.swift
//  ConsolidationNotes
//
//  Created by Daniel Gx on 08/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class DetailView: UIViewController, StoryboardInitialize {

    // MARK: - Properties
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var coordinator: DetailFlow?
    var note = [Notes]()
    var loadNote: Notes?
    var noteIndex: Int?
    var making: Bool!
    
    // MARK: - Actions
    
    @objc func doneTapped() {
        saveNotes()
        coordinator?.coordinatorToStart()
    }
    
    @objc func shareTapped() {
        guard let shareNote = noteTextView.text else {
            alertController(withTitle: "Sorry", message: "No note found, please type and try again!")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [shareNote], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func trashTapped() {
        if !making {
            note.remove(at: noteIndex!)
            deleteRemovedNote()
            coordinator?.coordinatorToStart()
        } else {
            coordinator?.coordinatorToStart()
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let backgroundImage = UIImage(named: "white_wall") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
            noteTextView.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        customizeNavigationController()
        setupCorrectView()
    }
    
    // MARK: - Methods
    
    func customizeNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        navigationController?.isToolbarHidden = false
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        fixedSpace.width = 20.0
        
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashTapped)))
        items.append(fixedSpace)
        items.append(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped)))
        
        toolbarItems = items
    }
    
    func setupCorrectView() {
        if isPossible() {
            loadSelectedNote()
        }
    }
    
    func saveNotes() {
        let jsonEncoder = JSONEncoder()
        note.append(Notes(text: noteTextView.text, modificationDate: Date()))
        if let savedData = try? jsonEncoder.encode(note) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            alertController(withTitle: "Warning!", message: "Failed to save note.")
        }
    }
    
    func deleteRemovedNote() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(note) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            alertController(withTitle: "Warning!", message: "Failed to save note.")
        }
    }
    
    func loadSelectedNote() {
        if !making {
            noteTextView.text = note[noteIndex!].text
        } else {
            noteTextView.text = "Type your note here!"
        }
    }
    
    func isPossible() -> Bool {
        if making {
            return false
        } else {
            return true
        }
    }
}
