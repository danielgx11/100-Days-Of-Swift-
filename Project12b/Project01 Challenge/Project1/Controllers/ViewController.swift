//
//  ViewController.swift
//  Project1
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: MainCoordinator?
    var pictures = [String]()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(accessImages), with: nil)
        customizeNavigationController()
    }
    
    // MARK: - Methods
    
    func customizeNavigationController() {
        title = "Storm View"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func accessImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - TableView life cycle
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! CustomMainCell
        
        let imageToLoad = pictures[indexPath.row]        
        cell.nameImage.text = pictures[indexPath.item]
        cell.image.image = UIImage(named: imageToLoad)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.coordinator?.detailImage(to: pictures[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

