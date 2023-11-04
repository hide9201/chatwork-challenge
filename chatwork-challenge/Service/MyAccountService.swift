//
//  MyAccountService.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import Combine

struct MyAccountService {
    
    func getMyAccount(token: String) -> AnyPublisher<MyAccount, Error> {
        return API.shared.call(MyAccountTarget.getMyAccount(token: token))
    }
}

