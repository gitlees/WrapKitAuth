//
//  TokenStorage.swift
//  WrapKitAuth
//
//  Created by Stas Lee on 30/6/23.
//

import Foundation

public protocol TokenStorage {
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func set(accessToken: String) -> Bool
    func set(refreshToken: String) -> Bool
}
