// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaAPI.SimulateTransaction {
    typealias Response = SolanaResponse<Result>

    struct Result: Decodable {
        let context: SolanaContext
        let value: Value
    }

    struct Value: Decodable {
        let err: [String: ErrorObject]?
        let unitsConsumed: UInt64
        let accounts: [Account?]
        let logs: [String]
    }

    struct Account: Decodable {
        let executable: Bool
        let lamports: UInt64
        let owner: String // base58 pubKey
        let rentEpoch: UInt64
        let data: [String]
    }

    struct ErrorObject: Decodable {
        let array: [Any]

        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            var array: [Any] = []
            while(container.isAtEnd == false) {
                if let index = try container.decodeIfPresent(Int.self) {
                    array.append(index)
                }
                if let object = try container.decodeIfPresent([String : Int].self) {
                    array.append(object)
                }
            }
            self.array = array
        }
    }
}
