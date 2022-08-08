//
//  PixabayImageCell.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class PixabayImageCell: UICollectionViewCell {
    
    static let reuseId = "PixabayImageCell"
    var previewImageUrl: String = "" {
        didSet {
            guard !previewImageUrl.isEmpty else { return }           
            NetworkHelper.shared.loadImage(from: previewImageUrl) { image in
                guard let image = image else { return }
                self.imageView.image = image
            }
        }
    }
    
    private var imageView = UIImageView()
    var titleLabel = CustomLabel(text: "title", style: .title2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius    = 10
        imageView.clipsToBounds         = true
        imageView.contentMode           = .scaleAspectFill
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.cellPadding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.cellPadding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.cellPadding),
            imageView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
