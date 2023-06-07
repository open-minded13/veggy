//
//  NetworkManager.swift
//  Veggy
//
//  Created by Derrick Ding on 6/2/23.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    static let shared = NetworkManager()
        
    private init() { }
    
    private let maxWaitTime = 15.0
    
    var commonHeaders: HTTPHeaders = [
        "user_id": "123",
        "token": "xxx-xx"
    ]
    
    func get(baseURL: String, route: String, parameters: [String: Any]?) async throws -> Data {
        // You must resume the continuation exactly once
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                baseURL + route,
                parameters: parameters,
                headers: commonHeaders,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
