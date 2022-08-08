//
//  SignInViewController.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    let largeTitleLabel = CustomLabel(text: "Authorization", style: .largeTitle)
    let emailTextField = CustomTextField(text: "", placeholder: "Email", keyboardType: .emailAddress, secureTextEntry: false)
    let passwordTextField = CustomTextField(text: "", placeholder: "Password", keyboardType: .default, secureTextEntry: true)
    let signInButton = CustomButton(title: "Sign in")
    let registerButton = CustomButton(title: "Register", backgroundColor: .systemGreen)
    let emailValidationLabel = CustomLabel(text: "Invalid email address", style: .title2)
    let passwordValidationLabel = CustomLabel(text: "Invalid password", style: .title2)
    
    private let viewModel = SignInViewModel()
    
    let userDefaults = UserDefaults.standard
    
    lazy var registeredEmail = userDefaults.string(forKey: "email") ?? ""
    lazy var registeredPassword = userDefaults.string(forKey: "password") ?? ""
    
    lazy var users: [String : String] = [
        "giorgi@gmail.com" : "giorgi2022",
        "pixabay@gmail.com" : "pixabay123",
        "user@gmail.com" : "user1",
        "test@yahoo.com" : "test12345",
        registeredEmail : registeredPassword
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configViews()
        configureValidationLabels()
        signInButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configViewController() {
        view.backgroundColor = .systemBackground
        title = ""
    }
    
    private func configViews() {
        configSearchTextField()
        configureButton()
    }
    
    private func setupTextFieldConstraints(_ textField: UITextField) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.padding),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupButtonConstraints(_ button: UIButton) {
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.padding),
            button.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupValidationLabelConstraints(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configSearchTextField() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)

        emailValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true

        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingDidEnd)

        emailTextField.delegate = self
        passwordTextField.delegate = self

        setupTextFieldConstraints(emailTextField)
        setupTextFieldConstraints(passwordTextField)

        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
        ])
    }

    private func configureButton() {
        view.addSubview(signInButton)
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(onTapSignIn), for: .touchUpInside)
        
        setupButtonConstraints(signInButton)
        setupButtonConstraints(registerButton)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            
            registerButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            
        ])
    }

    private func configureValidationLabels() {
        view.addSubview(emailValidationLabel)
        view.addSubview(passwordValidationLabel)
        view.addSubview(largeTitleLabel)
        
        setupValidationLabelConstraints(emailValidationLabel)
        setupValidationLabelConstraints(passwordValidationLabel)

        NSLayoutConstraint.activate([
            emailValidationLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            
            passwordValidationLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            
            largeTitleLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -30),
            largeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            largeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            largeTitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func checkValidForm(_ textField: UITextField, isEmail: Bool) {
        
        for (emails, passwords) in users {
            
            if isEmail {
                
                (textField.text == emails) ? (emailValidationLabel.isHidden = true) : (emailValidationLabel.isHidden = false)
                
            } else {
                
                (textField.text == passwords) ? (passwordValidationLabel.isHidden = true) : (passwordValidationLabel.isHidden = false)
            }
            
        }
    }
    
    @objc private func emailTextFieldDidChange() {
        checkValidForm(emailTextField, isEmail: true)
    }

    @objc private func passwordTextFieldDidChange() {
        checkValidForm(passwordTextField, isEmail: false)
    }
    
    @objc private func onTapRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func onTapSignIn() {
        
        if emailTextField.text?.isEmpty == true {
            
            emailValidationLabel.isHidden = false
            signInButton.isEnabled = false
        }
        
        if passwordTextField.text?.isEmpty == true {
            passwordValidationLabel.isHidden = false
            signInButton.isEnabled = false
        }
        
        for (emails, passwords) in users {
            if emailTextField.text == emails && passwordTextField.text == passwords {
                
                let searchVC = SearchViewController()
                navigationController?.pushViewController(searchVC, animated: true)
                
            }
        }
    }
}

// MARK:- UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
}
