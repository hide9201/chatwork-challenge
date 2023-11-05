//
//  Message.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/06.
//

import Foundation

struct Message: Codable {
    let messageId: String
    let account: Account
    let body: String
    let sendTime: Int
}
