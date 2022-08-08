//
//  SearchViewController.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searchTextField = CustomTextField(text: "Yellow", placeholder: "Search images", keyboardType: .default, secureTextEntry: false)
    let searchButton = CustomButton(title: "Search")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationItem.leftBarButtonItem = nil
    }
    
    private func configViewController() {
        view.backgroundColor = .systemBackground
        title = "Search"
    }
    
    private func configViews() {
        configSearchTextField()
        configGoButton()
    }
    
    private func configSearchTextField() {
        view.addSubview(searchTextField)

        searchTextField.delegate = self
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.padding),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.padding),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configGoButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 25),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.padding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.padding),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func goButtonTapped() {
        showResults()
    }
    
    private func showResults() {
        guard let searchText = searchTextField.text, searchText.count > 2 else { return }
        
        let resultsVc = ResultsViewController()
        resultsVc.searchText = searchText
        navigationController?.pushViewController(resultsVc, animated: true)
    }
}

// MARK:- UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // This method's called when the return key is tapped
        showResults()
        return true
    }
}
