//
//  DetailViewController.swift
//  Consolidation1
//
//  Created by Daniel Gx on 27/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: DetailCoordinator?
    var selectedImage: String?
    
    // MARK: - Outlets
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        customizeNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // MARK: - Funcs
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            debugPrint("No image found")
            return
        }
        guard let imageName = selectedImage else { return }
        
        let avc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }
    
    func customizeNavigationController() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = selectedImage?.uppercased()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    func setImage() {
        imageView.image = UIImage(named: selectedImage!)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
}
