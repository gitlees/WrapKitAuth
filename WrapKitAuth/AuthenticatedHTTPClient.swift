//
//  AuthenticatedHTTPClient.swift
//  WrapKitAuth
//
//  Created by Stas Lee on 30/6/23.
//

import Foundation
import WrapKitNetworking

public class AuthenticatedHTTPClientDecorator: HTTPClient {
    private let decoratee: HTTPClient
    private let getToken: (((String?) -> Void) -> Void)
    private let enrichRequestWithToken: ((inout URLRequest, String) -> Void)
    
    private let semaphore = DispatchSemaphore(value: 0)
    private let queue = DispatchQueue(label: "AuthenticatedHTTPClientDecorator", attributes: .concurrent)
    
    public init(
        decoratee: HTTPClient,
        getToken: @escaping (((String?) -> Void) -> Void),
        enrichRequestWithToken: @escaping ((inout URLRequest, String) -> Void)
    ) {
        self.decoratee = decoratee
        self.getToken = getToken
        self.enrichRequestWithToken = enrichRequestWithToken
    }
    
    public func dispatch(_ request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        var request = request
        getToken({ [weak self] token in
            if let token = token {
                self?.enrichRequestWithToken(&request, token)
            }
            self?.semaphore.signal()
        })
        semaphore.wait()
        return decoratee.dispatch(request, completion: completion)
    }
}
