// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaClient {
    struct GetFirstAvailableBlock {
        struct Response: Decodable, CustomStringConvertible {
            let id: Int
            let jsonrpc: String
            let result: Int?
            let error: SolanaError?

            var description: String {
                if let result {
                    return "first available block:\n" +
                    "\tfeature-set: \(result)"
                }
                if let error {
                    return "first available block:\n\t" + error.description
                }
                return "Something went wront, response is empty"
            }
        }
    }

    typealias SolanaFirstAvailableBlock = GetFirstAvailableBlock.Response
    func getFirstAvailableBlock() async throws -> SolanaFirstAvailableBlock {
        try await post(
            SimpleSolanaRequest(
                method: "getFirstAvailableBlock"
            )
        )
    }
}
