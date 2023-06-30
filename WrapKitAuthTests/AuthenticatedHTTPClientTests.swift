//
//  AuthenticatedHTTPClientTests.swift
//  WrapKitAuthTests
//
//  Created by Stas Lee on 30/6/23.
//

import XCTest
import WrapKitAuth
import WrapKitNetworking

final class AuthenticatedHTTPClientTests: XCTestCase {
    func test_dispatch_enrichesURLRequestWithToken() {
        let (sut, spy) = makeSUT(getToken: { $0("token") }) { request, token in
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        sut.dispatch(URLRequest(url: makeURL()), completion: { _ in }).resume()
        XCTAssertEqual(spy.requestedURLRequests.first?.value(forHTTPHeaderField: "Authorization"), "Bearer token")
    }
    
    func test_dispatch_doesNotEnrichURLRequest_whenTokenNil() {
        let (sut, spy) = makeSUT(getToken: { $0(nil) }) { request, token in
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        sut.dispatch(URLRequest(url: makeURL()), completion: { _ in }).resume()
        XCTAssertEqual(spy.requestedURLRequests.first?.value(forHTTPHeaderField: "Authorization"), nil)
    }
}

extension AuthenticatedHTTPClientTests {
    private func makeSUT(
        getToken: @escaping (((String?) -> Void) -> Void),
        enrichRequestWithToken: @escaping ((inout URLRequest, String) -> Void),
        file: StaticString = #file,
        line: UInt = #line
    ) -> (HTTPClient, HTTPClientSpy) {
        let decoratee = HTTPClientSpy()
        let sut = AuthenticatedHTTPClientDecorator(
            decoratee: decoratee,
            getToken: getToken,
            enrichRequestWithToken: enrichRequestWithToken
        )
        return (sut, decoratee)
    }
}
