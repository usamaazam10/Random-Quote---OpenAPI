//
//  AuthenticationMiddleware.swift
//  Random Quote
//
//  Created by Usama Azam on 19/11/2024.
//

import OpenAPIRuntime
import Foundation
import HTTPTypes

/// Injects an authorization header to every request.
struct AuthenticationMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[HTTPField.Name("X-Api-Key")!] = "+EFYIZG9PIxLniijunME1Q==3yYd7aC3tUF8oAzQ"
        return try await next(request, body, baseURL)
    }
}
