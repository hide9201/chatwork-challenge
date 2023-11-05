//
//  RoomTarget.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Moya

enum RoomTarget {
    case getRoomList
    case getMessages(roomId: Int)
    case postMessage(roomId: Int, body: String)
}

extension RoomTarget: BaseTarget {
    var path: String {
        switch self {
        case .getRoomList:
            return "/rooms"
        case .getMessages(let roomId):
            return "rooms/\(roomId)/messages"
        case .postMessage(let roomId, _):
            return "rooms/\(roomId)/messages"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRoomList:
            return .get
        case .getMessages:
            return.get
        case .postMessage:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRoomList:
            return .requestPlain
        case .getMessages:
            let parameters: Parameters = [
                "force": "1"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .postMessage(_, let body):
            let parameters: Parameters = [
                "body": body
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        }
    }
}
