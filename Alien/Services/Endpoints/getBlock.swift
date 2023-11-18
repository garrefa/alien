import Foundation

extension SolanaClient {
    struct GetBlock {
        struct Request: Encodable {
            struct Param: Encodable {
                struct ExtraParam: Encodable {
                    let transactionDetails: String = "none"
                    let rewards: Bool = false
                }

                let slot: UInt64
                let extraParams = ExtraParam()

                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(self.slot)
                    try container.encode(extraParams)
                }
            }

            let id: Int
            let jsonrpc = "2.0"
            let method = "getBlock"
            let params: Param

            init(
                id: Int = 0,
                _ slot: UInt64
            ) {
                self.id = id
                self.params = Param(slot: slot)
            }
        }

        struct Response: Decodable, CustomStringConvertible {
            struct Result: Decodable {
                let blockhash: String
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

    typealias BlockResponse = GetBlock.Response
    func getBlock(_ slot: UInt64) async throws -> BlockResponse {
        try await post(
            GetBlock.Request(slot)
        )
    }
}


