// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaClient {
    struct GetVersion {
        struct Response: Decodable, CustomStringConvertible {
            struct Result: Decodable {
                let featureSet: UInt64
                let solanaCore: String

                enum CodingKeys: String, CodingKey {
                    case featureSet = "feature-set"
                    case solanaCore = "solana-core"
                }
            }

            let id: Int
            let jsonrpc: String
            let result: Result?
            let error: SolanaError?

            var description: String {
                if let result {
                    return "version:\n" +
                        "\tfeature-set: \(result.featureSet)\n" +
                        "\tsolana-core: \(result.solanaCore)"
                }
                if let error {
                    return "version:\n\t" + error.description
                }
                return "Something went wront, response is empty"
            }
        }
    }

    typealias SolanaVersion = GetVersion.Response
    func getVersion() async throws -> SolanaVersion {
        try await post(
            SimpleSolanaRequest(
                method: "getVersion"
            )
        )
    }
}
