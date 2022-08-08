//
//  ResultsViewModel.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import Foundation

struct ResultsViewModel: Hashable {
    
    let pixabayImage: PixabayImage?
    
    init(pixabayImage: PixabayImage) {
        self.pixabayImage = pixabayImage
    }
    
    var user: String {
        pixabayImage?.user ?? ""
    }
    
    var tags: String {
        pixabayImage?.tags ?? ""
    }
    
    var views: Int {
        pixabayImage?.views ?? 0
    }
    
    var likes: Int {
        pixabayImage?.likes ?? 0
    }
    
    var comments: Int {
        pixabayImage?.comments ?? 0
    }
    
    var favourites: Int {
        pixabayImage?.collections ?? 0
    }
    
    var downloads: Int {
        pixabayImage?.downloads ?? 0
    }
    
    var type: String {
        pixabayImage?.type ?? ""
    }
    
    var size: Int {
        pixabayImage?.imageSize ?? 0
    }
    
    var previewURL: String {
        pixabayImage?.previewURL ?? ""
    }
}
