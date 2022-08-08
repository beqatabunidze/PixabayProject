//
//  CustomTextField.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    convenience init(text: String, placeholder: String, keyboardType: UIKeyboardType, secureTextEntry: Bool) {
        self.init(frame: .zero)
        self.text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = secureTextEntry
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont(name: "Areal", size: 12)
        

        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
    }
}
