//
//  BaseTarget.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Moya

protocol BaseTarget: TargetType {
}

extension BaseTarget {
    
    var baseURL: URL {
        return URL(string: AppConstant.API.baseURL)!
    }
    
    var headers: [String : String]? {
        return [
            "x-chatworktoken": "\(AppConstant.token)",
            "accept": "application/json",
            "content-type": "application/x-www-form-urlencoded"
        ]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var sampleData: Data {
        return Data()
    }
}

typealias Parameters = [String: Any]
