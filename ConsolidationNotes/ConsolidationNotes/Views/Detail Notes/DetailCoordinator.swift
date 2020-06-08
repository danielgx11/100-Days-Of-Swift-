//
//  DetailCoordinator.swift
//  ConsolidationNotes
//
//  Created by Daniel Gx on 08/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol DetailFlow: class {
    func coordinatorToStart()
}

class DetailCoordinator: Coordinator, DetailFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    let notes: [Notes]
    let noteIndex: Int
    let making: Bool
    
    init(navigationController: UINavigationController, note: [Notes], noteIndex: Int, making: Bool) {
        self.navigationController = navigationController
        self.notes = note
        self.noteIndex = noteIndex
        self.making = making
    }
    
    func start() {
        let detailView = DetailView.initFromStoryboard()
        detailView.coordinator = self
        detailView.note = notes
        detailView.noteIndex = noteIndex
        detailView.making = making
        navigationController.pushViewController(detailView, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinatorToStart() {
        let notesCoordinator = NotesCoordinator(navigationController: navigationController)
        coordinate(to: notesCoordinator)
    }
}
