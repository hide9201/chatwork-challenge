//
//  MyAccountService.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/03.
//

import PromiseKit

struct MyAccountService {
    
    func getMyAccount() -> Promise<MyAccount> {
        return API.shared.call(MyAccountTarget.getMyAccount)
    }
}

