//
//  NotesTableView.swift
//  ConsolidationNotes
//
//  Created by Daniel Gx on 08/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class NotesTableView: UITableViewController, StoryboardInitialize {
    
    // MARK: - Properties
    
    var coordinator: NotesFlow?
    var notes = [Notes]()
    var noteIndex: Int?
        
    // MARK: - Actions
    
    @objc func editTapped() {
        
    }
    
    @objc func newNoteTapped() {
        noteIndex = notes.count
        coordinator?.coordinateToMakeNewNote(notes: notes, noteIndex: noteIndex ?? 0, making: true)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let backgroundImage = UIImage(named: "white_wall") {
            tableView.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
        customizeNavigationController()
        loadNotes()
    }

    // MARK: - Methods
    
    func customizeNavigationController() {
        Styling.setNavigationBarColors(for: navigationController)
        Styling.setToolbarColors(for: navigationController)
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNoteTapped)))
        toolbarItems = items
    }
    
    func loadNotes() {
        let defaults = UserDefaults.standard
        
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Notes].self, from: savedNotes)
                tableView.reloadData()
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getTitleText(split: [Substring]) -> String {
        if split.count >= 1 {
            return String(split[0])
        }
        
        return "No additional text."
    }
    
    func getSubtitleText(split: [Substring]) -> String {
        if split.count >= 2 {
            return String(split[1])
        }
        
        return "This note is empty!"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let backgroundImage = UIImage(named: "white_wall") {
            cell.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        let note = notes[indexPath.row]
        let split = note.text.split(separator: "\n", maxSplits: 2, omittingEmptySubsequences: true)
        cell.textLabel?.text = getTitleText(split: split)
        cell.detailTextLabel?.text = getSubtitleText(split: split)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.coordinateToNotesDetail(withNote: notes, noteIndex: indexPath.row, making: false)
    }
}
