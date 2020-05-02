//
//  PhotoDetailCoordinator.swift
//  ConsolidationIV - CollectionPhotos
//
//  Created by Daniel Gx on 02/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol PhotoDetailFlow: class {
    /// flow methods
}

class PhotoDetailCoordinator: Coordinator, PhotoDetailFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    let selectedImageName: String
    let subtitleImage: String
    
    init(navigationController: UINavigationController, selectedImageName: String, subtitleImage: String) {
        self.navigationController = navigationController
        self.selectedImageName = selectedImageName
        self.subtitleImage = subtitleImage
    }
    
    func start() {
        let photoDetail = PhotoDetail()
        photoDetail.selectedImageName = selectedImageName
        photoDetail.subtitleImage = subtitleImage
        photoDetail.coordinator = self
        navigationController.pushViewController(photoDetail, animated: true)
    }
}
