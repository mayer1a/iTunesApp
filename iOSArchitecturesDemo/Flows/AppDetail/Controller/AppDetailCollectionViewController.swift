//
//  AppDetailCollectionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailCollectionViewController: UIViewController {

    // MARK: - Properties

    var screenshotsView: AppDetailScreenshotsView? {
        return isViewLoaded ? view as? AppDetailScreenshotsView : nil
    }

    // MARK: - Private properties

    private struct Constants {
        static let reuseIdentifier = "screenshotsCollectionViewCell"
    }

    private var images: [UIImage?] = [] {
        didSet {
            screenshotsView?.collectionView.reloadData()
        }
    }

    private let screenshotsModelFactory = AppDetailScreenshotsModelFactory()

    // MARK: - Constructions

    init(app: ITunesApp) {
        super.init(nibName: nil, bundle: nil)
        configureModel(from: app)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = AppDetailScreenshotsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        screenshotsView?.collectionView.register(AppDetailScreenshotsCollectionViewCell.self,
                                                 forCellWithReuseIdentifier: Constants.reuseIdentifier)

        screenshotsView?.collectionView.delegate = self
        screenshotsView?.collectionView.dataSource = self


    }

    // MARK: - Private functions

    private func configureModel(from appModel: ITunesApp) {
        screenshotsModelFactory.construct(from: appModel) { [weak self] images in
            self?.images = images
        }
    }

}

// MARK: - UICollectionViewDataSource

extension AppDetailCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequedCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier,
                                                            for: indexPath)

        guard let cell = dequedCell as? AppDetailScreenshotsCollectionViewCell else { return UICollectionViewCell() }

        cell.setupData(images[indexPath.item])

        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension AppDetailCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationViewController = AppDetailScreenshotsFullScreenViewController(images: images)

        navigationController?.present(destinationViewController, animated: true)

    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppDetailCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12.0
    }

}
