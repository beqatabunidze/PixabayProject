//
//  RegisterViewController.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    let emailTextField = CustomTextField(text: "", placeholder: "Email", keyboardType: .emailAddress, secureTextEntry: false)
    let passwordTextField = CustomTextField(text: "", placeholder: "Password", keyboardType: .default, secureTextEntry: true)
    let ageTextField = CustomTextField(text: "", placeholder: "Age", keyboardType: .numberPad, secureTextEntry: false)
    let registerButton = CustomButton(title: "Register", backgroundColor: .systemGreen)
    let emailValidationLabel = CustomLabel(text: "Invalid email address", style: .title2)
    let passwordValidationLabel = CustomLabel(text: "Invalid password", style: .title2)
    let ageValidationLabel = CustomLabel(text: "Age must be between 18-99 years", style: .title2)
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configViews()
        configureValidationLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configViewController() {
        view.backgroundColor = .systemBackground
        title = "Registration"
    }
    
    private func configViews() {
        configureTextField()
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
    
    private func configureTextField() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(ageTextField)
        
        emailValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
        ageValidationLabel.isHidden = true
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(ageTextFieldDidChange), for: .editingChanged)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        
        setupTextFieldConstraints(emailTextField)
        setupTextFieldConstraints(passwordTextField)
        setupTextFieldConstraints(ageTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            ageTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            
            passwordTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 25)
        ])
    }
    
    private func configureButton() {
        view.addSubview(registerButton)
        
        registerButton.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        
        setupButtonConstraints(registerButton)
        
        NSLayoutConstraint.activate([
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16)
            
        ])
    }
    
    private func configureValidationLabels() {
        view.addSubview(emailValidationLabel)
        view.addSubview(passwordValidationLabel)
        view.addSubview(ageValidationLabel)
        
        setupValidationLabelConstraints(emailValidationLabel)
        setupValidationLabelConstraints(passwordValidationLabel)
        setupValidationLabelConstraints(ageValidationLabel)
        
        NSLayoutConstraint.activate([
            emailValidationLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            
            ageValidationLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 5),
            
            passwordValidationLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5)
        ])
    }
    
    private func checkValidForm(_ textField: UITextField, isEmail: Bool) {
        
    }
    
    private func invalidEmail(_ value: String) -> String? {
        
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            return "Invalid Email Address"
        }
        
        return nil
    }
    
    private func invalidAge(_ value: String) -> String? {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
            return "Age must contain only digits"
        }
        
        if (Int(value) ?? 0) < 18 || (Int(value) ?? 0) > 99 {
            return "You must be between 18-99 years old"
        }
        return nil
    }
    
    private func invalidPassword(_ value: String) -> String? {
        
        if value.count < 6 {
            return "Password must be at least 6 characters"
        }
        
        if value.count > 12 {
            return "Password is too long must be 6-12 characters long"
        }
        
        if containsDigit(value) {
            return "Password must contain at least 1 digit"
        }
        
        if containsLowerCase(value) {
            return "Password must contain at least 1 lowercase character"
        }
        
        if containsUpperCase(value) {
            return "Password must contain at least 1 uppercase character"
        }
        return nil
    }
    
    private func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    @objc private func emailTextFieldDidChange() {
        if let email = emailTextField.text {
            if let errorMessage = invalidEmail(email) {
                emailValidationLabel.text = errorMessage
                emailValidationLabel.isHidden = false
            } else {
                
                emailValidationLabel.isHidden = true
            }
        }
    }
    
    @objc private func ageTextFieldDidChange() {
        
        if let age = ageTextField.text {
            
            if let errorMessage = invalidAge(age) {
                ageValidationLabel.text = errorMessage
                ageValidationLabel.isHidden = false
            } else {
                ageValidationLabel.isHidden = true
            }
        }
    }
    
    @objc private func passwordTextFieldDidChange() {
        
        if let password = passwordTextField.text {
            if let errorMessage = invalidPassword(password) {
                passwordValidationLabel.text = errorMessage
                passwordValidationLabel.isHidden = false
            } else {
                passwordValidationLabel.isHidden = true
            }
        }
    }
    
    @objc private func onTapRegister() {
        
        if passwordTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false && ageTextField.text?.isEmpty == false {
            userDefaults.set(emailTextField.text, forKey: "email")
            userDefaults.set(passwordTextField.text, forKey: "password")
            
            let searchVC = SearchViewController()
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}

// MARK:- UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
}

