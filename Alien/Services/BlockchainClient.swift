// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

import Foundation

protocol BlockchainClient {
    func post<T: Decodable>(
        _ data: Encodable
    ) async throws -> T

    func post<T: Decodable>(
        _ data: Encodable,
        debug: Bool
    ) async throws -> T
}

extension BlockchainClient {
    func post<T: Decodable>(
        _ data: Encodable
    ) async throws -> T {
        try await post(data, debug: false)
    }
}
