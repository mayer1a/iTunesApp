//
//  SongCellTableViewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SongCellTableViewCell: UITableViewCell {

    // MARK: - Properties

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = availableLabelColor
        label.backgroundColor = availableBakgroundColor
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.backgroundColor = availableBakgroundColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var explicitLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.backgroundColor = .systemRed
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var buyButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.backgroundColor = availableBakgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: - Private properties

    private lazy var availableBakgroundColor: UIColor = {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }()

    private lazy var availableLabelColor: UIColor = {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }()

    // MARK: - Constructions

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        [titleLabel, subtitleLabel].forEach { $0.text = nil }
        buyButton.setTitle(" ", for: .normal)
        explicitLabel.isHidden = true
    }

    // MARK: - Functions

    func configure(with cellModel: ITunesSong) {
        titleLabel.text = cellModel.trackName
        subtitleLabel.text = "\(cellModel.artistName) - \(cellModel.collectionName) - \(cellModel.artwork)"
        buyButton.setTitle("cost", for: .normal)
        explicitLabel.isHidden = false // cellModel.isExplicit
    }

    // MARK: - Private functions

    private func configureUI() {
        addTitleLabel()
        addSubtitleLabel()
        addExplicitLabel()
        addBuyButton()
    }

    private func addTitleLabel() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            titleLabel.trailingAnchor.constraint(equalTo: explicitLabel.leadingAnchor, constant: -12.0)
        ])
    }

    private func addSubtitleLabel() {
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: buyButton.leadingAnchor, constant: -40.0)
        ])
    }

    private func addExplicitLabel() {
        contentView.addSubview(explicitLabel)

        NSLayoutConstraint.activate([
            explicitLabel.trailingAnchor.constraint(lessThanOrEqualTo: buyButton.leadingAnchor, constant: -40.0),
            explicitLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }

    private func addBuyButton() {
        contentView.addSubview(buyButton)

        NSLayoutConstraint.activate([
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            buyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}
