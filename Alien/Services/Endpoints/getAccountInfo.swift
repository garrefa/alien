// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaClient {
    struct GetAccountInfo {
        struct Request: Encodable {
            let id: Int
            let jsonrpc = "2.0"
            let method = "getAccountInfo"
            let params: [String]

            init(
                id: Int = 0,
                _ pubKey: String
            ) {
                self.id = id
                self.params = [pubKey]
            }
        }

        struct Response: Decodable, CustomStringConvertible {
            struct Result: Decodable {
                struct Value: Decodable {
                    let data: String
                    let executable: Bool
                    let lamports: UInt64
                    let owner: String
                    let rentEpoch: UInt64
                }

                let value: Value?
                let context: SolanaContext?
            }

            let id: Int
            let jsonrpc: String
            let result: Result
            let error: SolanaError?

            var description: String {
                if let balance = result.value?.lamports {
                    let lamports = Measurement<CryptoAmount>(
                        value: Double(balance),
                        unit: .lamports
                    )

                    return "balance:\n" +
                        "\t\(lamports.converted(to: .solana).formattedString)\n" +
                        "\t\(lamports.formattedString)\n"
                }
                if let error {
                    return "balance:\n\t" + error.description
                }
                return "Something went wront, response is empty"
            }
        }
    }

    typealias AccountInfo = GetAccountInfo.Response
    func getAccountInfo(_ pubKey: String) async throws -> AccountInfo {
        try await post(
            GetAccountInfo.Request(pubKey)
        )
    }
}


