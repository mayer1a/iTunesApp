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

    private let presenter: SearchSongViewOutput
    private let songCellFactory = SongCellModelFactory()
    private let imageDownloader = ImageDownloader()

    private let emptyResultView = UIView()

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
        super.loadView()
        self.view = SearchSongView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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

        presenter.cellWillUpdate(fromUrl: cellModel.artworkUrl) { image in
            cell.songImage.image = image
        }
        
        cell.configure(with: cellModel)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
        guard let query = searchBar.text, query.count != 0 else {
            searchBar.resignFirstResponder()
            return
        }

        searchBar.resignFirstResponder()
        self.presenter.viewDidSearch(with: query)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.resignFirstResponder()
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
        searchSongView?.tableView.reloadData()
    }

    func hideNoResults() {
        self.emptyResultView.isHidden = true
    }

    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }

}
