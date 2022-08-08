//
//  PropertyFileHelper.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

struct PropertyFileHelper {
    
    var hasLoadedProperties: Bool { return propertyFile != nil ? true : false }
    private var propertyFile: [String : AnyObject]?

    init(file: String) {
        propertyFile = readPropertyFile(filename: file)
    }
    
    func readProperty(key: String) -> String? {
        guard propertyFile != nil else { return nil }
        guard let value = propertyFile![key] as? String else { return nil }
       
        return value
    }

    func readPropertyFile(filename: String) -> [String : AnyObject]? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist") else { return nil }
        guard let contents = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else { return nil }
        
        return contents
    }
}
