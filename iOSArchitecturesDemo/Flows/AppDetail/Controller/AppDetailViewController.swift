//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    public var app: ITunesApp
    
    lazy var headerViewController = AppDetailHeaderViewController(app: self.app)
    lazy var whatsNewViewController = AppDetailWhatsNewViewController(app: self.app)
    lazy var screenshotsViewController = AppDetailCollectionViewController(app: self.app)
    
    // MARK: - Construction
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    // MARK: - Private Functions
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
        addHeaderViewController()
        addDescriptionViewController()
        addScreenshotsViewController()
    }
    
    private func addHeaderViewController() {
        addChild(headerViewController)
        view.addSubview(headerViewController.view)
        headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func addDescriptionViewController() {
        addChild(whatsNewViewController)
        view.addSubview(whatsNewViewController.view)
        whatsNewViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            whatsNewViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            whatsNewViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            whatsNewViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    private func addScreenshotsViewController() {
        addChild(screenshotsViewController)
        view.addSubview(screenshotsViewController.view)
        screenshotsViewController.didMove(toParent: self)

        var topBottomInsets: CGFloat = 0.0

        if let collectionViewInsets = screenshotsViewController.screenshotsView?.collectionViewLayout.sectionInset {
            topBottomInsets = collectionViewInsets.top + collectionViewInsets.bottom
        }

        NSLayoutConstraint.activate([
            screenshotsViewController.view.topAnchor.constraint(equalTo: self.whatsNewViewController.view.bottomAnchor),
            screenshotsViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            screenshotsViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            screenshotsViewController.view.heightAnchor.constraint(equalToConstant: 400 + topBottomInsets)
        ])
    }
}
