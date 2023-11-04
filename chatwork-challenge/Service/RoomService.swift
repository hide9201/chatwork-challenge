//
//  RoomService.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import Combine

struct RoomService {
    
    func getRoomList(token: String) -> AnyPublisher<[Room], Error> {
        return API.shared.call(RoomTarget.getRoomList(token: token))
    }
}
