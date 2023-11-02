//
//  API.swift
//  chatwork-challenge
//
//  Created by hide on 2023/11/02.
//

import Moya
import PromiseKit

final class API {
    
    // MARK: - Static
    
    static let shared = API()
    
    // MARK: - Property
    
    private let provider: MoyaProvider<MultiTarget>
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    // MARK: - Public
    
    func call<T: Decodable, Target: TargetType>(_ request: Target) -> Promise<T> {
        let target = MultiTarget(request)
        return Promise { resolver in
            self.provider.request(target) { result in
                switch result {
                case .success(let result):
                    do {
                        resolver.fulfill(try self.decoder.decode(T.self, from: result.data))
                    } catch {
                        resolver.reject(error)
                    }
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    // MARK: - Initializer
    
    private init() {
        provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin()])
    }
}
