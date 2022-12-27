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
        let label = UILabel()
        label.textColor = .white
        label.text = "E"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.backgroundColor = .explicitRed
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) lazy var buyButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.backgroundColor = availableBakgroundColor
        button.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        button.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        button.setContentCompressionResistancePriority(UILayoutPriority(752), for: .horizontal)
        button.setContentCompressionResistancePriority(UILayoutPriority(752), for: .vertical)
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

    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.contentMode = .scaleAspectFit
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

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
        songImage.image = nil
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
        addSubviewUIComponents()
        addSongImageViewConstraints()
        addTitleStackViewConstraints()
        addExplicitLabelConstraints()
        addBuyButtonConstraints()
    }

    private func addSubviewUIComponents() {
        titlesStackView.addArrangedSubview(titleLabel)
        titlesStackView.addArrangedSubview(subtitleLabel)

        contentView.addSubview(songImage)
        contentView.addSubview(titlesStackView)
        contentView.addSubview(explicitLabel)
        contentView.addSubview(buyButton)
    }

    private func addSongImageViewConstraints() {
        NSLayoutConstraint.activate([
            songImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            songImage.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8.0),
            songImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8.0),
            songImage.heightAnchor.constraint(equalToConstant: 64),
            songImage.widthAnchor.constraint(equalTo: songImage.heightAnchor)
        ])
    }

    private func addTitleStackViewConstraints() {
        NSLayoutConstraint.activate([
            titlesStackView.centerYAnchor.constraint(greaterThanOrEqualTo: songImage.centerYAnchor),
            titlesStackView.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: 12.0),
            titlesStackView.trailingAnchor.constraint(equalTo: explicitLabel.leadingAnchor, constant: -12.0)
        ])
    }

    private func addExplicitLabelConstraints() {
        NSLayoutConstraint.activate([
            explicitLabel.trailingAnchor.constraint(lessThanOrEqualTo: buyButton.leadingAnchor, constant: -20.0),
            explicitLabel.centerYAnchor.constraint(equalTo: titlesStackView.centerYAnchor),
            explicitLabel.widthAnchor.constraint(equalToConstant: 13),
            explicitLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
    }

    private func addBuyButtonConstraints() {
        NSLayoutConstraint.activate([
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            buyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buyButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20),
            buyButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
