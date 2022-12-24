//
//  AppDetailWhatsNewViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailWhatsNewViewController: UIViewController {

    // MARK: - Private properties

    private let app: ITunesApp

    private var appDetailWhatsNewView: AppDetailWhatsNewView? {
        return self.isViewLoaded ? self.view as? AppDetailWhatsNewView : nil
    }

    // MARK: - Constructions

    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = AppDetailWhatsNewView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    // MARK: - Private functions

    private func setupData() {
        appDetailWhatsNewView?.versionTitle.text = app.version
        appDetailWhatsNewView?.releaseDateTitle.text = app.releaseDate
        appDetailWhatsNewView?.descriptionTitle.text = app.releaseNotes
    }

}
