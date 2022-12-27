//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongViewInput: class {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: class {
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

final class SearchSongPresenter {

    weak var viewInput: (UIViewController & SearchSongViewInput)?

    // MARK: - Private Properties

    private let searchService = ITunesSearchService()

    // MARK: - Private Functions

    private func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }

            self.viewInput?.throbber(show: false)

            result.withValue { songs in
                if songs.isEmpty {
                    self.viewInput?.showNoResults()
                    return
                }

                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = songs
            } .withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }

    private func openSongDetails(with song: ITunesSong) { }
}

// MARK: - SearchViewOutput

extension SearchSongPresenter: SearchSongViewOutput {

    // MARK: - Functions

    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestSongs(with: query)
    }

    func viewDidSelectSong(_ song: ITunesSong) {
        self.openSongDetails(with: song)
    }
}
