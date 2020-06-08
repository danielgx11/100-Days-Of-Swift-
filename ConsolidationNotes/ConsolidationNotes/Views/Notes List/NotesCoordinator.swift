//
//  NotesCoordinator.swift
//  ConsolidationNotes
//
//  Created by Daniel Gx on 08/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol NotesFlow: class {
    func coordinateToMakeNewNote(notes: [Notes], noteIndex: Int, making: Bool )
    func coordinateToNotesDetail(withNote note: [Notes], noteIndex: Int, making: Bool) // TODO: Passing data
}

class NotesCoordinator: Coordinator, NotesFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let notesTableView = NotesTableView.initFromStoryboard()
        notesTableView.coordinator = self
        navigationController.pushViewController(notesTableView, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToMakeNewNote(notes: [Notes], noteIndex: Int, making: Bool) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, note: notes, noteIndex: noteIndex, making: making)
        coordinate(to: detailCoordinator)
    }
    
    func coordinateToNotesDetail(withNote note: [Notes], noteIndex: Int, making: Bool) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, note: note, noteIndex: noteIndex, making: making)
        coordinate(to: detailCoordinator)
    }
}
