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
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            debugPrint("No image found!")
            return
        }
        guard let imageName = selectedImage else {
            debugPrint("No name image found!")
            return
        }
        let drawImage = UIImage(data: image)
        guard let shareImage = drawImageAndtext(withImage: drawImage, andText: "From Storm View", size: drawImage?.size) else { return }
        
        let vc = UIActivityViewController(activityItems: [shareImage, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true )
        
    }
    
    func customizeNavigationController() {
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    func setImage() {
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    func drawImageAndtext(withImage image: UIImage?, andText text: String, size: CGSize?) -> UIImage? {
        guard let image = image else { return nil }
        guard let size = size else { return nil }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            
            let stormImage = image
            stormImage.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs: [NSAttributedString.Key: Any] = [
                .font : UIFont.systemFont(ofSize: 30),
                .paragraphStyle: paragraphStyle
            ]

            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            attributedString.draw(with: CGRect(x: 0, y: 40, width: image.size.width, height: 40), options: .usesLineFragmentOrigin, context: nil)
        }
        
        return img
    }
}
