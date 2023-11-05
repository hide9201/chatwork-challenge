//
//  MyAccountTarget.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Moya

enum MyAccountTarget {
    case getMyAccount
}

extension MyAccountTarget: BaseTarget {
    var path: String {
        switch self {
        case .getMyAccount:
            return "/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyAccount:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyAccount:
            return .requestPlain
        }
    }
}
