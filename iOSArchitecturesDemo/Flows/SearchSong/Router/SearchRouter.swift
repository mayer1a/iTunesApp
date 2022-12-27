//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 27.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    func openDetails(for song: ITunesSong)
}

final class SearchRouter: SearchRouterInput {

    // MARK: - Properties

    weak var viewController: UIViewController?

    // MARK: - Functions

    func openDetails(for song: ITunesSong) {
        // create and push song details VC
    }
}
