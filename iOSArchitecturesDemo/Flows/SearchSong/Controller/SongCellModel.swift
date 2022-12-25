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
    let songArtist: String
    let songAlbum: String
    let isExplicitContent: Bool
    let songCost: Double
    let artworkUrl: URL?
}

final class SongCellModelFactory {

    // MARK: - Functions

    func construct(from itunesSongModel: ITunesSong) -> SongCellModel {
        let songName = itunesSongModel.trackName
        let isExplicitContent = itunesSongModel.advisoryRating == "Explicit" ? true : false
        let songCost = itunesSongModel.cost
        let songAlbum = itunesSongModel.collectionName
        let songArtist = itunesSongModel.artistName

        var artworkUrl: URL? = nil

        if let artwork = itunesSongModel.artwork {
            artworkUrl = URL(string: artwork)
        }

        return SongCellModel(songName: songName,
                             songArtist: songArtist ?? "",
                             songAlbum: songAlbum ?? "",
                             isExplicitContent: isExplicitContent,
                             songCost: songCost,
                             artworkUrl: artworkUrl)
    }
}
