//
//  DetailViewController.swift
//  Project1
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: MainCoordinator?
    var selectedImage: String?
    
    // MARK: - Outlets
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(selectedImage?.isEmpty == false, "Sorry, Selected image is empty")
        setImage()
        customizeNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // MARK: - Funcs
    
    func customizeNavigationController() {
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setImage() {
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
}
