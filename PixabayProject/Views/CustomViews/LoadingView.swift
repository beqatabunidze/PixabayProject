//
//  LoadingView.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private var spinner = CustomSpinner(frame: .zero)
    private var textLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(superView: UIView) {
        self.init(frame: superView.bounds)
        textLabel.text = "Loading..."
    }
    
    convenience init(superView: UIView, text: String) {
        self.init(frame: superView.bounds)
        textLabel.text = "Getting \(text)..."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(animated: Bool) {
        if !animated {
            alpha = 1
            return
        }
        
        UIView.animate(withDuration: 0.25) { self.alpha = 1 }
    }
    
    func hide(animated: Bool) {
        if !animated {
            alpha = 0
            return
        }
        
        UIView.animate(withDuration: 0.25) { self.alpha = 0 }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        alpha = 0
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.startAnimating()
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        textLabel.textColor = .label
        textLabel.tintColor = .label
        textLabel.textAlignment = .center
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 60),
            spinner.heightAnchor.constraint(equalToConstant: 60),
            
            textLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: UIConstants.padding),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.padding),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.padding),
            textLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
