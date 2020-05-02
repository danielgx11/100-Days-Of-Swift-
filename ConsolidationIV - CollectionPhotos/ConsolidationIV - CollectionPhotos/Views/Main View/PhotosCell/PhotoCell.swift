//
//  PhotoCell.swift
//  ConsolidationIV - CollectionPhotos
//
//  Created by Daniel Gx on 02/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let photo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        //TODO: Selected Image
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    let subtitles: UILabel = {
        let subtitle = UILabel(frame: .zero)
        subtitle.numberOfLines = .zero
        subtitle.font = UIFont(name: "Marker Felt", size: 14)
        subtitle.textAlignment = .center
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        self.contentView.addSubview(photo)
        self.contentView.addSubview(subtitles)
        
        photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        photo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        photo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        subtitles.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 8).isActive = true
        subtitles.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4).isActive = true
        subtitles.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4).isActive = true
        subtitles.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
