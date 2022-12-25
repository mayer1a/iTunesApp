//
//  SearchSongViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchSongViewController: UIViewController {

    // MARK: - Properties

    var searchResults = [ITunesSong]() {
        didSet {
            self.searchSongView?.tableView.isHidden = false
            self.searchSongView?.tableView.reloadData()
            self.searchSongView?.searchBar.resignFirstResponder()
        }
    }

    // MARK: - Private Properties

    private struct Constants {
        static let reuseIdentifier = "searchSongReuseId"
    }

    private var searchSongView: SearchSongView? {
        return isViewLoaded ? self.view as? SearchSongView : nil
    }

    private let searchService = ITunesSearchService()
    private let presenter: SearchSongViewOutput
    private let songCellFactory = SongCellModelFactory()

    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let emptyResultView = UIView()
    private let emptyResultLabel = UILabel()

    // MARK: - Construction

    init(presenter: SearchSongViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        searchSongView?.searchBar.delegate = self
        searchSongView?.tableView.register(SongCellTableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        searchSongView?.tableView.delegate = self
        searchSongView?.tableView.dataSource = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.throbber(show: false)
    }
}

//MARK: - UITableViewDataSource
extension SearchSongViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)

        guard let cell = dequeuedCell as? SongCellTableViewCell else { return dequeuedCell }

        let song = self.searchResults[indexPath.row]
        let cellModel = songCellFactory.construct(from: song)

        cell.configure(with: cellModel)

        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchSongViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = searchResults[indexPath.row]
        presenter.viewDidSelectSong(song)
    }
}

//MARK: - UISearchBarDelegate
extension SearchSongViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }

        self.presenter.viewDidSearch(with: query)
    }
}

// MARK: - Input
extension SearchSongViewController: SearchSongViewInput {

    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

    func showNoResults() {
        self.emptyResultView.isHidden = false
        self.searchResults = []
        self.tableView.reloadData()
    }

    func hideNoResults() {
        self.emptyResultView.isHidden = true
    }

    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }

}
