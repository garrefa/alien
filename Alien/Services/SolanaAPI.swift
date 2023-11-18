// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

struct SolanaAPI {
    let client: BlockchainClient

    init(client: BlockchainClient = SolanaBlockchainClient()) {
        self.client = client
    }
}
