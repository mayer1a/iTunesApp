//
//  AppDetailScreenshotsView.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailScreenshotsView: UIView {

    // MARK: - Properties

    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        label.text = "Предпросмотр"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        collectionViewLayout.itemSize = CGSize(width: 92, height: 200)
        collectionViewLayout.scrollDirection = .horizontal

        return collectionViewLayout
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        return collectionView
    }()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureComponents()
    }

    // MARK: - Private functions

    private func configureComponents() {
        translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .white

        addSubview(collectionView)

        addCollectionViewConstraints()
    }

    private func addCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
