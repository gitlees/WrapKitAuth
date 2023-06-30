//
//  KeychainTokenService.swift
//  WrapKitAuth
//
//  Created by Stas Lee on 30/6/23.
//

import KeychainSwift
import WrapKitNetworking

public final class TokenService {
    private let refresh: ((String, @escaping ((String?) -> Void)) -> Void)
    private let storage: TokenStorage
    
    public init(
        storage: TokenStorage,
        refresh: @escaping (String, @escaping (String?) -> Void) -> Void
    ) {
        self.storage = storage
        self.refresh = refresh
    }
    
    public func getAccessToken(completion: @escaping ((String?) -> Void)) {
        if let accessToken = storage.getAccessToken() {
            completion(accessToken)
        } else if let refreshToken = storage.getRefreshToken() {
            refresh(refreshToken) { [weak self, completion] accessToken in
                if let accessToken = accessToken {
                    self?.set(accessToken: accessToken, completion: { isSuccess in
                        isSuccess ? completion(accessToken) : completion(nil)
                    })
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
    
    public func set(accessToken: String, completion: ((Bool) -> Void)) {
        completion(storage.set(accessToken: accessToken))
    }
    
    public func set(refreshToken: String, completion: ((Bool) -> Void)) {
        completion(storage.set(refreshToken: refreshToken))
    }
}
