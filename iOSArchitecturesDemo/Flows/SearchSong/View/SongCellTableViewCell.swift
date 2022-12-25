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

    private(set) lazy var songImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = availableBakgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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

    func configure(with cellModel: SongCellModel) {
        titleLabel.text = cellModel.songName
        subtitleLabel.text = cellModel.subtitile
        buyButton.setTitle(cellModel.songCost, for: .normal)
        explicitLabel.isHidden = !cellModel.isExplicitContent
    }

    // MARK: - Private functions

    private func configureUI() {
        addSongImageView()
        addTitleLabel()
        addSubtitleLabel()
        addExplicitLabel()
        addBuyButton()
    }

    private func addSongImageView() {
        contentView.addSubview(songImage)

        NSLayoutConstraint.activate([
            songImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            songImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            songImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            songImage.heightAnchor.constraint(equalToConstant: 64.0),
            songImage.widthAnchor.constraint(equalToConstant: 64.0)
        ])
    }

    private func addTitleLabel() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: songImage.centerYAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 12.0),
            titleLabel.trailingAnchor.constraint(equalTo: explicitLabel.leadingAnchor, constant: -12.0)
        ])
    }

    private func addSubtitleLabel() {
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 12.0),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: buyButton.leadingAnchor, constant: -40.0)
        ])
    }

    private func addExplicitLabel() {
        contentView.addSubview(explicitLabel)

        NSLayoutConstraint.activate([
            explicitLabel.trailingAnchor.constraint(lessThanOrEqualTo: buyButton.leadingAnchor, constant: -40.0),
            explicitLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor)
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
