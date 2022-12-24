//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 24.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailWhatsNewView: UIView {

    // MARK: - Properties

    private(set) lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        label.text = "Что нового"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var versionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var releaseDateTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.text = "Что нового"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions

    private func configureComponents() {
        addSubview(headerTitle)
        addSubview(versionTitle)
        addSubview(releaseDateTitle)
        addSubview(descriptionTitle)

        addHeaderTitleConstraints()
        addVersionTitleConstraints()
        addReleaseDateTitleConstraints()
        addDescriptionTitleConstraints()
    }

    private func addHeaderTitleConstraints() {
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            headerTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    private func addVersionTitleConstraints() {
        NSLayoutConstraint.activate([
            versionTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            versionTitle.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 16)
        ])
    }

    private func addReleaseDateTitleConstraints() {
        NSLayoutConstraint.activate([
            releaseDateTitle.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 16),
            releaseDateTitle.leadingAnchor.constraint(greaterThanOrEqualTo: versionTitle.trailingAnchor, constant: 16),
            releaseDateTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    private func addDescriptionTitleConstraints() {
        NSLayoutConstraint.activate([
            descriptionTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionTitle.topAnchor.constraint(equalTo: versionTitle.bottomAnchor, constant: 16),
            descriptionTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
}
