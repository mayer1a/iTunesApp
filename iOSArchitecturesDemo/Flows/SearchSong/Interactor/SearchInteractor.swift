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
    func getImage(fromUrl url: URLConvertible, completion: @escaping DownloadImageCompletion)
}

final class SearchInteractor: SearchInteractorInput {

    // MARK: - Private properties

    private let searchService: ITunesSearchService
    private let downloaderService: ImageDownloader

    // MARK: - Construction

    init(searchService: ITunesSearchService, downloaderService: ImageDownloader) {
        self.searchService = searchService
        self.downloaderService = downloaderService
    }

    // MARK: - Functions

    func requestSongs(with query: String, completion: @escaping (Alamofire.Result<[ITunesSong]>) -> Void) {
        searchService.getSongs(forQuery: query, completion: completion)
    }

    func getImage(fromUrl url: URLConvertible, completion: @escaping DownloadImageCompletion) {
        DispatchQueue.global().async { [weak self] in
            self?.downloaderService.getImage(fromUrl: url, completion: completion)
        }
    }

}
