//
//  CustomImageView.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

protocol CustomImageViewDelegate: AnyObject {
    func imageLoadComplete(success: Bool)
}

class CustomImageView: UIImageView {

    weak var delegate: CustomImageViewDelegate?
    var imageUrl: String? {
        didSet {
            guard let iu = imageUrl else { return }
            NetworkHelper.shared.loadImage(from: iu) { [weak self] img in
                guard let self = self else { return }
                guard let img = img else {
                    DispatchQueue.main.async { self.delegate?.imageLoadComplete(success: false) }
                    return
                }

                self.image = img
                DispatchQueue.main.async { self.delegate?.imageLoadComplete(success: true) }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 25
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
