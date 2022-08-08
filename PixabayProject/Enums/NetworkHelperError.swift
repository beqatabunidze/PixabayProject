//
//  NetworkHelperError.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation

enum NetworkHelperError: Error {
    case noError
    case searchTermTooShort
    case endPointPropertiesMissing
    case internalError
    case badUrl
    case badResponse
    case noData
    case notDecodable
    
    func description() -> String {
        switch self {
            case .noError:                      return "No Error"
            case .searchTermTooShort:           return "Search Term too short"
            case .endPointPropertiesMissing:    return "End Point Properties Missing"
            case .internalError:                return "Internal Error"
            case .badUrl:                       return "Bad URL"
            case .badResponse:                  return "Bad Response"
            case .noData:                       return "No Data"
            case .notDecodable:                 return "Not Decodable (JSON couldn't be parsed)"
        }
    }
}
