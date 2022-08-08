//
//  SignInViewModel.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation
import UIKit

//protocol SignInViewModelProtocol: AnyObject {
//    func onTapSignIn()
//    func onTapRegister()
//    func emailTextFieldDidChange(_ emailTextField: CustomTextField, emailLabel: CustomLabel, users: [String : String])
//    func passwordTextFieldDidChange(_ passwordTextField: CustomTextField, passwordlLabel: CustomLabel, users: [String : String])
//}

public class SignInViewModel {
    
    var navigationController: UINavigationController?
    
    @objc func onTapRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    private func checkValidForm(_ textField: UITextField, emailLabel: CustomLabel?, passwordLabel: CustomLabel?, users: [String : String]) {
        
        for (emails, passwords) in users {
            
            if emailLabel != nil {
                (textField.text == emails) ? (emailLabel?.isHidden = true) : (emailLabel?.isHidden = false)
            } else {
                (textField.text == passwords) ? (passwordLabel?.isHidden = true) : (passwordLabel?.isHidden = false)
            }
            
        }
    }
    
    @objc func emailTextFieldDidChange(_ emailTextField: CustomTextField, emailLabel: CustomLabel, users: [String : String]) {
        checkValidForm(emailTextField, emailLabel: emailLabel, passwordLabel: nil, users: users)
    }

    @objc func passwordTextFieldDidChange(_ passwordTextField: CustomTextField, passwordlLabel: CustomLabel, users: [String : String]) {
        checkValidForm(passwordTextField, emailLabel: nil, passwordLabel: passwordlLabel, users: users)
    }
    
    
    
}
