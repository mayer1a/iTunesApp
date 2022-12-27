//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 27.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchInteractorInput {
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

final class SearchInteractor: SearchInteractorInput {

    // MARK: - Private properties

    private let searchService: ITunesSearchService

    // MARK: - Construction

    init(searchService: ITunesSearchService) {
        self.searchService = searchService
    }

    // MARK: - Functions

    func requestSongs(with query: String, completion: @escaping (Alamofire.Result<[ITunesSong]>) -> Void) {
        searchService.getSongs(forQuery: query, completion: completion)
    }

}
