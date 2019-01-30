//
//  ClashRoyaleAPI.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/18/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import Foundation

class ClashRoyaleAPI {
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjA4MywiaWRlbiI6IjIzNjU4NDQ0MjI4MDQxMTEzNyIsIm1kIjp7fSwidHMiOjE1NDM3ODk0NDA5MDB9.ca5UFP2cQ3jZ4xLbF565_UmP8_wU_kNwIlEdnTn0Ssk"
    
    func getClanInfo(clanTag: String, completion: @escaping (_ clanInfo: ClanInfo?) -> Void) {
        let urlString = "https://api.royaleapi.com/clan/\(clanTag)"
        guard
            let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedUrlString)
        else {
            assertionFailure("Failed to create url")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    completion(nil)
                    return
                }
            }
            
            if let data = data {
                let clanInfo = try? JSONDecoder().decode(ClanInfo.self, from: data)
                completion(clanInfo)
            } else if let error = error {
                completion(nil)
                print(error.localizedDescription)
            } else {
                completion(nil)
                print("Unknown error!??!")
            }
        }
        
        task.resume()
    }
    
    func getPlayerInfo(playerTags: [String], completion: @escaping (_ PlayerInfo: [PlayerInfo]?) -> Void) {
        let urlString = "https://api.royaleapi.com/player/\(playerTags.joined(separator: ","))"
        
        guard
            let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedUrlString)
            else {
                assertionFailure("Failed to create url")
                return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    completion(nil)
                    return
                }
            }
            
            if let data = data {
                let playerInfo = try? JSONDecoder().decode([PlayerInfo].self, from: data)
                completion(playerInfo)
            } else if let error = error {
                completion(nil)
                print(error.localizedDescription)
            } else {
                completion(nil)
                print("Unknown error!??!")
            }
        }
        task.resume()
    }
}
