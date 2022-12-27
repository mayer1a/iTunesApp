//
//  MainTabBarController.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureComponents()
        setupViewControllers()
    }

    // MARK: - Private functions

    private func configureComponents() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .varna
            tabBar.tintColor = .varna
            tabBar.backgroundColor = .systemGray6
        } else {
            view.backgroundColor = .white
            tabBar.tintColor = .black
            tabBar.backgroundColor = UIColor.lightGray
        }
    }

    private func setupViewControllers() {
        viewControllers = [
            createNavigationController(for: SearchModuleBuilder.build(), title: "Apps", image: "apps.iphone"),
            createNavigationController(for: SearchSongModuleBuilder.build(), title: "Songs", image: "music.note")
        ]
    }

    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            image: String) -> UIViewController
    {
        let navVC = UINavigationController(rootViewController: rootViewController)
        navVC.tabBarItem.title = title

        let titleColor: UIColor = view.backgroundColor == .varna ? .white : .black
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        navVC.navigationBar.prefersLargeTitles = true
        navVC.navigationBar.isTranslucent = false

        rootViewController.navigationItem.title = "Search \(title) via iTunes"

        if #available(iOS 13.0, *) {
            navVC.tabBarItem.image = UIImage(systemName: image)
        }

        return navVC
    }

}
