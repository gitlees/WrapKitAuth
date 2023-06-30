//
//  TokenServiceTests.swift
//  WrapKitAuthTests
//
//  Created by Stas Lee on 30/6/23.
//

import XCTest
import WrapKitAuth
import WrapKitNetworking

final class TokenServiceTests: XCTestCase {
    func test_setAccessToken_savesToken() {
        let (sut, spy) = makeSUT(refresh: { _,_  in })
        sut.set(accessToken: "accessToken", completion: { _ in })
        XCTAssertEqual(spy.getAccessToken(), "accessToken")
    }
    
    func test_setRefreshToken_savesToken() {
        let (sut, spy) = makeSUT(refresh: { _,_  in })
        sut.set(refreshToken: "refreshToken", completion: { _ in })
        XCTAssertEqual(spy.getRefreshToken(), "refreshToken")
    }
    
    func test_getAccessToken_completesWithToken_whenSet() {
        let (sut, _) = makeSUT(refresh: { _,_  in })
        let exp = expectation(description: "await completion")
        sut.set(accessToken: "accessToken", completion: { _ in })
        
        sut.getAccessToken { token in
            XCTAssertEqual(token, "accessToken")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_getAccessToken_refreshesAccessToken_whenSet() {
        let (sut, _) = makeSUT(refresh: { refreshToken, completion  in
            completion("accessToken")
        })
        let exp = expectation(description: "await completion")
        sut.set(refreshToken: "refreshToken", completion: { _ in })
        
        sut.getAccessToken { token in
            XCTAssertEqual(token, "accessToken")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_getAccessToken_completesWithNil_ifNoTokensFound() {
        let (sut, _) = makeSUT(refresh: { refreshToken, completion  in
            completion("accessToken")
        })
        let exp = expectation(description: "await completion")
        
        sut.getAccessToken { token in
            XCTAssertEqual(token, nil)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
    }
}

extension TokenServiceTests {
    private func makeSUT(
        refresh: @escaping ((String, @escaping ((String?) -> Void)) -> Void),
        file: StaticString = #file,
        line: UInt = #line
    ) -> (TokenService, TokenStorageSpy) {
        let storage = TokenStorageSpy()
        let sut = TokenService(
            storage: storage,
            refresh: refresh
        )
        return (sut, storage)
    }
    
    class TokenStorageSpy: TokenStorage {
        private var accessToken: String?
        private var refreshToken: String?
        
        func getAccessToken() -> String? {
            return accessToken
        }
        
        func getRefreshToken() -> String? {
            return refreshToken
        }
        
        func set(accessToken: String) -> Bool {
            self.accessToken = accessToken
            return true
        }
        
        func set(refreshToken: String) -> Bool {
            self.refreshToken = refreshToken
            return true
        }
    }
}
