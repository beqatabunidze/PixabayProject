//
//  DetailViewController.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var pixabayImage: PixabayImage? {
        didSet {
            guard pixabayImage != nil else { return }
            spinner.startAnimating()
            loading = true
            imageView.imageUrl = pixabayImage!.largeImageURL
            
            let value = Double(pixabayImage?.imageSize ?? 0) * 0.000001
            let roundedValue = round(value * 100) / 100.0
            
            infoLabel.text = (pixabayImage?.tags ?? "") + "\n\n" + (pixabayImage?.type ?? "") + " • " + "\(roundedValue)" + "MB"
        }
    }

    private var loading = false
    private var imageView = CustomImageView(frame: .zero)
    private var infoLabel = CustomLabel(text: "", style: .title1)
    private var footer = CustomView()
    private var spinner = CustomSpinner(frame: .zero)
    private var tapGesture: UITapGestureRecognizer!
    private var menuInteraction: UIContextMenuInteraction!
    private var imageHelper: ImageActionHelper?
    private var button = CustomButton(title: "More")

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViews()
        configureButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func onTapButton() {
        guard pixabayImage != nil else { return }
        ImageActionHelper.showMetaData(data: pixabayImage!)
    }

    private func configViewController() {
        view.backgroundColor = .systemBackground
        title = "Details"
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)

    }

    private func configViews() {
        imageView.delegate = self
        view.addSubview(imageView)
        view.addSubview(spinner)
        view.addSubview(footer)
        view.addSubview(button)
        footer.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.padding),
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.padding),
            footer.heightAnchor.constraint(equalToConstant: 100),
            
            button.bottomAnchor.constraint(equalTo: footer.topAnchor, constant: -12),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.padding),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            infoLabel.bottomAnchor.constraint(equalTo: footer.bottomAnchor),
            infoLabel.topAnchor.constraint(equalTo: footer.topAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: footer.centerYAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: footer.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: footer.trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 50),
            
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 60),
            spinner.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension DetailViewController: CustomImageViewDelegate {
    
    func imageLoadComplete(success: Bool) {
        self.spinner.stopAnimating()
        loading = false
    }
}
