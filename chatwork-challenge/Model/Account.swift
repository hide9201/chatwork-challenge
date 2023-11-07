//
//  Account.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import Foundation

struct Account: Codable {
    let accountId: Int
    let name: String
    let avatarImageUrl: URL
}
