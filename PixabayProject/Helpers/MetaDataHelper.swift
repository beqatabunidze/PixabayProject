//
//  MetaDataHelper.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation

struct MetaDataHelper {
    
    static func convertDataToDictionary(data: PixabayImage) -> [String : String] {
        var metaDict = [String : String]()
        
        metaDict["User"]                = data.user
        metaDict["Likes"]               = String(data.likes)
        metaDict["Views"]               = String(data.views)
        metaDict["Comments"]            = String(data.comments)
        metaDict["Downloads"]           = String(data.downloads)
        metaDict["Favorites"]           = String(data.collections)

        return metaDict
    }
    
    static func convertRowToDictKey(row: Int) -> String? {
        guard let metaDataKeys = MetaDataKeys(rawValue: row) else { return nil }
        return metaDataKeys.propertyName()
    }
}
