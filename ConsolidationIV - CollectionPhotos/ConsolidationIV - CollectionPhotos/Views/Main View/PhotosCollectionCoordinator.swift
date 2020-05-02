//
//  PhotosCollectionCoordinator.swift
//  ConsolidationIV - CollectionPhotos
//
//  Created by Daniel Gx on 02/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol PhotosCollectionFlow: class {
    func coordinateToDetail(imageName: String, subtitle: String)
}

class PhotosCollectionCoordinator: Coordinator, PhotosCollectionFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let photosCollection = PhotosCollection()
        photosCollection.coordinator = self
        navigationController.pushViewController(photosCollection, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToDetail(imageName: String, subtitle: String) {
        let photoDetailCoordinator = PhotoDetailCoordinator(navigationController: navigationController, selectedImageName: imageName, subtitleImage: subtitle)
        coordinate(to: photoDetailCoordinator)
    }
}
