//
//  SearchSongModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchSongModuleBuilder {

    // MARK: - Functions

    static func build() -> (UIViewController & SearchSongViewInput) {
        let router = SearchRouter()
        let searchService = ITunesSearchService()
        let downloadService = ImageDownloader()
        let interactor = SearchInteractor(searchService: searchService, downloaderService: downloadService)
        let presenter = SearchSongPresenter(interactor: interactor, router: router)
        let viewController = SearchSongViewController(presenter: presenter)

        presenter.viewInput = viewController
        router.viewController = viewController

        return viewController
    }
}

