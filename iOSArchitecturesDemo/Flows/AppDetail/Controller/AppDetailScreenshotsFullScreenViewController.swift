//
//  AppDetailScreenshotsFullScreenViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 27.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailScreenshotsFullScreenViewController: UIViewController {

    // MARK: - Properties

    private var screenshotsView: AppDetailScreenshotsView? {
        return isViewLoaded ? view as? AppDetailScreenshotsView : nil
    }
    
    private struct Constants {
        static let reuseIdentifier = "screenshotsFullscreenViewCell"
    }

    private lazy var itemSizeWithInsets: CGSize = {
        guard let itemSize = screenshotsView?.safeAreaLayoutGuide.layoutFrame else { return .zero }
        
        let leftRightInsets = sectionInset.left + sectionInset.right
        let width = itemSize.width - leftRightInsets

        let resultSize = CGSize(width: width, height: width * 1.77)

        return resultSize
    }()

    private var images: [UIImage?]
    private let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)


    // MARK: - Constructions

    init(images: [UIImage?]) {
        self.images = images
        super.init(nibName: nil, bundle: nil)
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
        screenshotsView?.collectionView.isPagingEnabled = true
    }
    
}

// MARK: - UICollectionViewDelegate

extension AppDetailScreenshotsFullScreenViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension AppDetailScreenshotsFullScreenViewController: UICollectionViewDataSource {

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

// MARK: - UICollectionViewDelegateFlowLayout

extension AppDetailScreenshotsFullScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return sectionInset
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return itemSizeWithInsets
    }
}
