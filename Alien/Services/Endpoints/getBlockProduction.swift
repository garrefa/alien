import Foundation

extension SolanaClient {
    struct GetBlockProduction {
        struct Response: Decodable, CustomStringConvertible {
            struct Result: Decodable {
                struct Context: Decodable {
                    let slot: UInt64
                }

                let context: Context
            }

            let id: Int
            let jsonrpc: String
            let result: Result?
            let error: SolanaError?

            var description: String {
                if let result {
                    return "getBlock:\n\t\(result)"
                }
                if let error {
                    return "getBlock:\n\t" + error.description
                }
                return "Something went wront, response is empty"
            }
        }
    }

    typealias BlockProductionResponse = GetBlockProduction.Response
    func getBlockProduction() async throws -> BlockProductionResponse {
        try await post(
            SimpleSolanaRequest(
                method: "getBlockProduction"
            )
        )
    }
}


