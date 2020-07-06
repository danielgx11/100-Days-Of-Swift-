//
//  MemeCell.swift
//  ConsolidationMemeGeneration
//
//  Created by Daniel Gx on 03/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MemeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var memeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var memeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Marker Felt", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
}

// MARK: - UISetup

extension MemeCell {
    private func setupUI() {
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(memeImage)
        roundedBackgroundView.addSubview(memeLabel)
        
        roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        roundedBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        roundedBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        memeImage.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor).isActive = true
        memeImage.leftAnchor.constraint(equalTo: roundedBackgroundView.leftAnchor).isActive = true
        memeImage.rightAnchor.constraint(equalTo: roundedBackgroundView.rightAnchor).isActive = true
        memeImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        memeLabel.topAnchor.constraint(equalTo: memeImage.bottomAnchor).isActive = true
        memeLabel.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor).isActive = true
        memeLabel.rightAnchor.constraint(equalTo: roundedBackgroundView.rightAnchor).isActive = true
        memeLabel.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor).isActive = true
    }
}
