//
//  ViewController.swift
//  Project6b
//
//  Created by Daniel Gx on 03/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.red
        label.text = "THESE"
        label.sizeToFit()
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.cyan
        label.text = "ARE"
        label.sizeToFit()
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.yellow
        label.text = "SOME"
        label.sizeToFit()
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.green
        label.text = "AWESOME"
        label.sizeToFit()
        return label
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.orange
        label.text = "LABELS"
        label.sizeToFit()
        return label
    }()
    

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }


}

// MARK: - UI Setup

extension ViewController {
    private func setupUI() {
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
                
        let viewDictionary = [ "label1" : label1,
                               "label2" : label2,
                               "label3" : label3,
                               "label4" : label4,
                               "label5" : label5
        ]
        
        for label in viewDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary))
        }
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewDictionary))
    }
}

