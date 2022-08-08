//
//  ImageActionHelper.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

struct ImageActionHelper {
    
    static func showMetaData(data: PixabayImage) {
        guard let navigationController = NavHelper.navigationController() else { return }
        let vc = MetaDataViewController()
        vc.pixabayImage = data
        navigationController.present(vc, animated: true, completion: nil)
    }
}
