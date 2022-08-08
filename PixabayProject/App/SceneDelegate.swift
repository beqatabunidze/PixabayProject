//
//  SceneDelegate.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }  // Get the window scene
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)  // Create a window
        guard window != nil else { return }

        window!.windowScene = windowScene
        window!.rootViewController = createNavController(with: createInitialViewControler())
        window!.makeKeyAndVisible()
    }
    
    private func createInitialViewControler() -> UIViewController { SignInViewController() }
    
    private func createNavController(with initialViewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: initialViewController)
    }
}

