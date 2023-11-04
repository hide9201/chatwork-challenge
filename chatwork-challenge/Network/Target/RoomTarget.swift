//
//  RoomTarget.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Moya

enum RoomTarget {
    case getRoomList(token: String)
    case postMessage(token: String, roomId: Int, message: String)
}

extension RoomTarget: BaseTarget {
    var path: String {
        switch self {
        case .getRoomList:
            return "/rooms"
        case .postMessage(_, let roomId, _):
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
        case .postMessage(_, _, let message):
            let parameters: Parameters = [
                "body": message
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getRoomList(let token):
            return [
                "x-chatworktoken": token,
                "accept": "application/json",
            ]
        case .postMessage(let token, _, _):
            return [
                "x-chatworktoken": token,
                "accept": "application/json",
                "content-type": "application/x-www-form-urlencoded"
            ]
        }
        
    }
}
