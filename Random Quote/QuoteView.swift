//
//  ContentView.swift
//  Random Quote
//
//  Created by Usama Azam on 19/11/2024.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct QuoteView: View {
    @State private var quote:Components.Schemas.Quote? = nil
    @State private var error:String? = nil
    
    let client: Client
    init() {
        self.client = Client(serverURL: try! Servers.Server1.url(), transport: URLSessionTransport(), middlewares: [AuthenticationMiddleware()])
    }
    
    var body: some View {
        VStack {
            if let quote, let quoteContent = quote.quote {
                Text(quoteContent).font(.system(size: 20))
            } else if let error {
                Text(error)
                    .font(.system(size: 20))
                    .foregroundStyle(.red)
            }
            
            Button("Get quote!") {
                Task { try? await getQuote() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func getQuote() async throws {
        quote = nil
        error = nil
        do {
            let response = try await client.get_sol_quotes(query: Operations.get_sol_quotes.Input.Query(category: "happiness"))
            switch response {
            case .ok(let quote):
                switch quote.body {
                case .json(let data):
                    self.quote = data.first
                }
            case .undocumented(_, _):
                self.error = "Unknown error"
            case .badRequest(let badRequestError):
                self.error = "\(badRequestError)"
            case .unauthorized(let unauthorizedError):
                self.error = "\(unauthorizedError)"
            case .internalServerError(let internalServerError):
                self.error = "\(internalServerError)"
            }
        } catch {
            self.error = error.localizedDescription
        }
        
    }
    
}

#Preview {
    QuoteView()
}

