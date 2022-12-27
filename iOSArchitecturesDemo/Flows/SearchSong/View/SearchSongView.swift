//
//  SearchSongView.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchSongView: UIView {

    // MARK: - Properties

    let searchBar = UISearchBar()
    let tableView = UITableView()
    let emptyResultView = UIView()
    let emptyResultLabel = UILabel()

    // MARK: - Private properties

    private lazy var availableBackgroundColor: UIColor = {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }()

    // MARK: - Constructions

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }

    // MARK: - Private properties

    private func configureUI() {
        backgroundColor = availableBackgroundColor

        addSearchBar()
        addTableView()
        addEmptyResultView()
        setupConstraints()
    }

    private func addSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Название музыки, имя артиста и др."
        searchBar.showsCancelButton = false
        searchBar.returnKeyType = .search
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        addSubview(searchBar)
    }

    private func addTableView() {
        tableView.rowHeight = 72.0
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
    }

    private func addEmptyResultView() {
        emptyResultView.backgroundColor = availableBackgroundColor
        emptyResultView.isHidden = true
        emptyResultView.translatesAutoresizingMaskIntoConstraints = false

        emptyResultLabel.text = "Nothing was found"
        emptyResultLabel.textColor = .darkGray
        emptyResultLabel.textAlignment = .center
        emptyResultLabel.font = .systemFont(ofSize: 12.0)
        emptyResultLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(emptyResultView)
        emptyResultView.addSubview(emptyResultLabel)
    }

    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            emptyResultView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            emptyResultLabel.topAnchor.constraint(equalTo: emptyResultView.topAnchor, constant: 12.0),
            emptyResultLabel.leadingAnchor.constraint(equalTo: emptyResultView.leadingAnchor),
            emptyResultLabel.trailingAnchor.constraint(equalTo: emptyResultView.trailingAnchor)
        ])
    }
}
