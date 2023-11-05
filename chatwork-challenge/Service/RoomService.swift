//
//  RoomService.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import Combine

struct RoomService {
    
    func getRoomList() -> AnyPublisher<[Room], Error> {
        return API.shared.call(RoomTarget.getRoomList)
    }
    
    func getMessages(roomId: Int) -> AnyPublisher<[Message], Error> {
        return API.shared.call(RoomTarget.getMessages(roomId: roomId))
    }
    
    func postMessage(roomId: Int, body: String) -> AnyPublisher<VoidModel, Error> {
        return API.shared.call(RoomTarget.postMessage(roomId: roomId, body: body))
    }
}
