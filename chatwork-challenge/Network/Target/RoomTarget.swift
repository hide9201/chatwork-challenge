//
//  RoomTarget.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Moya

enum RoomTarget {
    case getRoomList
    case postMessage(roomId: Int, message: String)
}

extension RoomTarget: BaseTarget {
    var path: String {
        switch self {
        case .getRoomList:
            return "/rooms"
        case .postMessage(let roomId, _):
            return "rooms/\(roomId)/messages"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRoomList:
            return .get
        case .postMessage:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRoomList:
            return .requestPlain
        case .postMessage(_, let message):
            let parameters: Parameters = [
                "body": message
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        }
    }
}
