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
    func cellWillUpdate(fromUrl url: URL?, completion: @escaping (UIImage?) -> Void)
}

final class SearchSongPresenter {

    weak var viewInput: (UIViewController & SearchSongViewInput)?

    // MARK: - Private Properties

    private let interactor: SearchInteractorInput
    private let router: SearchRouterInput

    // MARK: - Construction

    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Private Functions

    private func requestSongs(with query: String) {
        interactor.requestSongs(with: query) { [weak self] result in
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

    private func fetchSongImage(withUrl url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return }

        DispatchQueue.main.async { [weak self] in
            self?.interactor.getImage(fromUrl: url) { (image, _) in
                completion(image)
            }
        }
    }

}

// MARK: - SearchViewOutput

extension SearchSongPresenter: SearchSongViewOutput {

    // MARK: - Functions

    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestSongs(with: query)
    }

    func viewDidSelectSong(_ song: ITunesSong) {
        router.openDetails(for: song)
    }

    func cellWillUpdate(fromUrl url: URL?, completion: @escaping (UIImage?) -> Void) {
        fetchSongImage(withUrl: url, completion: completion)
    }

}
