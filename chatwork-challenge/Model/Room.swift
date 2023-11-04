//
//  Room.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import Foundation

struct Room: Codable {
    let roomId: Int
    let name: String
    let unreadNum: Int
    let iconPath: String
}
