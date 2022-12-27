//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let songName: String
    let isExplicitContent: Bool
    let songCost: String
    let artworkUrl: URL?
    let subtitile: String
}

final class SongCellModelFactory {

    // MARK: - Functions

    func construct(from itunesSongModel: ITunesSong) -> SongCellModel {
        let songName = itunesSongModel.trackName
        let isExplicitContent = itunesSongModel.advisoryRating == "Explicit" ? true : false

        var songCost = "Free"

        if let cost = itunesSongModel.cost {
            songCost = "\(cost) $"
        }

        let subtitle = "\(itunesSongModel.artistName ?? "") - \(itunesSongModel.collectionName ?? "")"
        var artworkUrl: URL? = nil

        if let artwork = itunesSongModel.artwork {
            artworkUrl = URL(string: artwork)
        }

        return SongCellModel(songName: songName,
                             isExplicitContent: isExplicitContent,
                             songCost: songCost,
                             artworkUrl: artworkUrl,
                             subtitile: subtitle)
    }
}
