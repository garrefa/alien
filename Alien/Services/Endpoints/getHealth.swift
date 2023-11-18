// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaClient {
    struct GetHealth {
        enum HealthStatus: String, Decodable {
            case ok
        }

        struct Response: Decodable, CustomStringConvertible {
            let id: Int
            let jsonrpc: String
            let result: HealthStatus?
            let error: SolanaError?

            var description: String {
                if let result {
                    return "health: \(result)"
                }
                if let error {
                    return "health:\n\t" + error.description
                }
                return "Something went wront, response is empty"
            }
        }
    }

    typealias SolanaHealth = GetHealth.Response
    func getHealth() async throws -> SolanaHealth {
        try await post(
            SimpleSolanaRequest(
                method: "getHealth"
            )
        )
    }
}
