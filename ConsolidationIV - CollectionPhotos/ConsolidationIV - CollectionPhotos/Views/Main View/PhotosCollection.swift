//
//  PhotosCollection.swift
//  ConsolidationIV - CollectionPhotos
//
//  Created by Daniel Gx on 02/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class PhotosCollection: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: PhotosCollectionFlow?
    var photos = [Photo]()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    // MARK: - Actions
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        customizeNavigationController()
    }
    
    // MARK: - Methods
    
    func customizeNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        navigationItem.title = "Photos Collection"
        navigationController?.navigationBar.tintColor = .black
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

// MARK: - UI Setup

extension PhotosCollection {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
}

// MARK: - CollectionView Delegate & DataSource

extension PhotosCollection: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
                
        let photo = photos[indexPath.row]
        cell.subtitles.text = photo.subtitle
        
        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        cell.photo.image = UIImage(contentsOfFile: path.path)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.coordinateToDetail(imageName: photos[indexPath.row].image, subtitle: photos[indexPath.row].subtitle)
    }
}

extension PhotosCollection: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpedData = image.jpegData(compressionQuality: 0.8) {
            try? jpedData.write(to: imagePath)
        }
        
        let photo = Photo(subtitle: "Unknown", image: imageName)
        photos.append(photo)
        collectionView.reloadData()
        
        dismiss(animated: true)
        
    }
}
