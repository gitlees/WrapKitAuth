//
//  KeychainStorage.swift
//  WrapKitAuth
//
//  Created by Stas Lee on 30/6/23.
//

import KeychainSwift

public class KeychainTokenStorage: TokenStorage {
    private let keychain = KeychainSwift()
    
    public init() { }
    
    public func getAccessToken() -> String? {
        return keychain.get("AccessToken")
    }
    
    public func getRefreshToken() -> String? {
        return keychain.get("RefreshToken")
    }
    
    public func set(accessToken: String) -> Bool {
        return keychain.set(accessToken, forKey: "AccessToken")
    }
    
    public func set(refreshToken: String) -> Bool {
        return keychain.set(refreshToken, forKey: "RefreshToken")
    }
    
    public func clear() -> Bool {
        return keychain.delete("AccessToken") && keychain.delete("RefreshToken")
    }
}
