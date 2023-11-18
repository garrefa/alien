// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

/// For Responses without result
typealias SimpleSolanaResponse = SolanaResponse<Int>

struct SolanaResponse<R: Decodable>: Decodable {
    let id: Int
    let jsonrpc: String
    let result: R?
    let error: SolanaError?
}
