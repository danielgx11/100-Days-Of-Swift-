//
//  InitialCollectionView.swift
//  ConsolidationMemeGeneration
//
//  Created by Daniel Gx on 03/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class InitialCollectionView: UIViewController, StoryboardInitialize {
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:  collectionViewLayout())
        collectionView.register(MemeCell.self, forCellWithReuseIdentifier: "Meme")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var coordinator: InitialFlow?
    var images: [UIImage] = [#imageLiteral(resourceName: "emoji")]
    var texts: [String] = ["vapovapo"]
    
    // MARK: - Actions
    
    @objc func importImage() {
        
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    func customizeNavigationController() {
        title = "Meme Generation"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importImage))
    }
    
}

// MARK: - CollectionViewDelegate and DataSource

extension InitialCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Meme", for: indexPath) as! MemeCell
        cell.memeImage.image = images.first
        cell.memeLabel.text = texts.first
        return cell
    }
}

// MARK: - UI Setup

extension InitialCollectionView {
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidhtHeightConstant: [String: CGFloat] = [
            "Widht": 120,
            "Height" : 120
        ]
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: cellWidhtHeightConstant["Widht"] ?? 120, height: cellWidhtHeightConstant["Height"] ?? 120)
        
        return layout
    }
}
