//
//  MyAccountService.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import Combine

struct MyAccountService {
    
    func getMyAccount() -> AnyPublisher<Account, Error> {
        return API.shared.call(MyAccountTarget.getMyAccount)
    }
}

