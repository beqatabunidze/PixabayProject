//
//  MetaDataKeys.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation

enum MetaDataKeys: Int {
    case user
    case views
    case likes
    case comments
    case favorites
    case downloads
    
    func propertyName() -> String {
        switch self {
        case .likes:            return "Likes"
        case .views:            return "Views"
        case .comments:         return "Comments"
        case .downloads:        return "Downloads"
        case .user:             return "User"
        case .favorites:        return "Favorites"
        }
    }
}
