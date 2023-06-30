//
//  KeychainStorageTests.swift
//  WrapKitAuthTests
//
//  Created by Stas Lee on 1/7/23.
//

import XCTest
import WrapKitAuth
import WrapKitNetworking

final class KeychainTokenStorageTests: XCTestCase {
    func test_tokenStorage_managesTokens() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.getAccessToken(), nil)
        XCTAssertEqual(sut.getRefreshToken(), nil)
        
        XCTAssertEqual(sut.set(accessToken: "access token"), true)
        XCTAssertEqual(sut.set(refreshToken: "refresh token"), true)
        
        XCTAssertEqual(sut.getAccessToken(), "access token")
        XCTAssertEqual(sut.getRefreshToken(), "refresh token")
    }
}

extension KeychainTokenStorageTests {
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> TokenStorage {
        return KeychainTokenStorage()
    }
}
