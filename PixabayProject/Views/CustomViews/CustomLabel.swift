//
//  CustomLabel.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    var textStyle: UIFont.TextStyle!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.text = "-"
        self.textStyle = .body
        
        config()
    }
    
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init(frame: .zero)
        self.text = text
        self.textStyle = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        textAlignment = .center
        numberOfLines = 0
        minimumScaleFactor = 0.75
        
        font = UIFont.preferredFont(forTextStyle: textStyle)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
    }
}
