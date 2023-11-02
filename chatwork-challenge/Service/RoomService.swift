//
//  RoomService.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import PromiseKit

struct RoomService {
    
    func getRoomList() -> Promise<[Room]> {
        return API.shared.call(RoomTarget.getRoomList)
    }
}
