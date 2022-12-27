//
//  AppDetailScreenshotsModelFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 26.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class AppDetailScreenshotsModelFactory {

    // MARK: - Private properties

    private let imageDownloader = ImageDownloader()
    private let dispatchGroup = DispatchGroup()

    // MARK: - Functions

    func construct(from app: ITunesApp, completion: @escaping ([UIImage?]) -> Void) {
        DispatchQueue.global().sync { [weak self] in
            var images: [UIImage?] = []

            app.screenshotUrls.forEach {
                self?.dispatchGroup.enter()

                self?.imageDownloader.getImage(fromUrl: $0){ (image, _) in
                    images.append(image)
                    self?.dispatchGroup.leave()
                }
            }

            self?.dispatchGroup.notify(queue: .main) {
                completion(images)
            }

        }
    }
}
