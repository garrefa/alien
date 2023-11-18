// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

/// For Requests without params
typealias SimpleSolanaRequest = SolanaRequest<Int>

struct SolanaRequest<E: Encodable>: Encodable {
    let id: Int
    let jsonrpc = "2.0"
    let method: String
    let params: E?

    init(
        id: Int = 0,
        method: String,
        params: E? = nil
    ) {
        self.id = id
        self.method = method
        self.params = params
    }
}
