//
//  ClanDownloader.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/17/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

class ClanDownloader {
    var isDownloading: Bool = false
    let clashRoyaleApi = ClashRoyaleAPI()

    // To be downloaded
    var clanInfo: ClanInfo?
    var playerInfos: [PlayerInfo]?
    var warLogs: [Warlog]?

    let clanTag: String

    init(clanTag: String) {
        self.clanTag = clanTag
    }

    func download(completion: @escaping (Clan?) -> Void) {
        guard !isDownloading else {
            return
        }

        isDownloading = true

        let group = DispatchGroup()

        // ENTER: downloadClanInfo
        group.enter()

        // ENTER: downloadPlayerInfos
        group.enter()

        // ENTER: downloadWarLogs
        group.enter()
        downloadWarLogs() {
            // LEAVE: downloadWarLogs
            group.leave()
        }

        downloadClanInfo() { [weak self] in
            guard let playerTags = self?.clanInfo?.returnPlayerTags else {
                self?.isDownloading = false
                completion(nil)
                return
            }

            // LEAVE: downloadClanInfo
            group.leave()

            self?.downloadPlayerInfos(playerTags: playerTags) {
                // LEAVE: downloadPlayerInfos
                group.leave()
            }
        }

        group.notify(queue: .global()) {
            guard
                let clanInfo = self.clanInfo,
                let playerInfos = self.playerInfos,
                let warLogs = self.warLogs
            else {
                self.isDownloading = false
                completion(nil)
                return
            }

            self.isDownloading = false
            completion(Clan(clanInfo: clanInfo, players: playerInfos, warLogs: warLogs, lastRefreshed: Date()))
        }
    }

    private func downloadClanInfo(completion: @escaping () -> Void) {
        clashRoyaleApi.getClanInfo(clanTag: clanTag) { [weak self] clanInfo in
            guard clanInfo?.tag != nil else {
                completion()
                return
            }

            self?.clanInfo = clanInfo
            completion()
        }
    }

    private func downloadPlayerInfos(playerTags: [String], completion: @escaping () -> Void) {
        clashRoyaleApi.getPlayerInfo(playerTags: playerTags) { [weak self] playerInfos in
            self?.playerInfos = playerInfos
            completion()
        }

    }

    private func downloadWarLogs(completion: @escaping () -> Void) {
        clashRoyaleApi.getWarLogs(clanTag: clanTag) { [weak self] warLogs in
            self?.warLogs = warLogs
            completion()
        }
    }
}
