//
//  AppDetailWhatsNewModelFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Artem Mayer on 25.12.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

struct WhatsNewModel {
    let version: String
    let releaseDate: String
    let releaseNotes: String
}

final class AppDetailWhatsNewModelFactory {

    // MARK: - Private properties

    private static let isoDateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()

        return dateFormatter
    }()

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current

        return dateFormatter
    }()

    // MARK: - Functions

    func constructViewModel(from app: ITunesApp) -> WhatsNewModel {
        let version = "Версия \(app.version)"

        guard
            let date = AppDetailWhatsNewModelFactory.isoDateFormatter.date(from: app.releaseDate),
            let notes = app.releaseNotes
        else {
            return WhatsNewModel(version: version, releaseDate: app.releaseDate, releaseNotes: "")
        }

        let releaseDateString = getDateStringPresentation(date)

        return WhatsNewModel(version: version,
                             releaseDate: releaseDateString,
                             releaseNotes: notes)
    }

    // MARK: - Private functions

    private func getDateStringPresentation(_ date: Date) -> String {
        let daysFromReleaseDate = getDaysFromReleaseDate(date.timeIntervalSince1970)

        switch daysFromReleaseDate {
        case 0:
            return "Сегодня"
        case 1:
            return "\(daysFromReleaseDate) день назад"
        case 2...4:
            return "\(daysFromReleaseDate) дня назад"
        case 5...6:
            return "\(daysFromReleaseDate) дней назад"
        default:
            return AppDetailWhatsNewModelFactory.dateFormatter.string(from: date)
        }
    }

    private func getDaysFromReleaseDate(_ releaseDate: TimeInterval) -> Int {
        let secondsInDay = 86400.0
        let daysLeft = (Date().timeIntervalSince1970 - releaseDate) / secondsInDay

        return Int(daysLeft)
    }
}
