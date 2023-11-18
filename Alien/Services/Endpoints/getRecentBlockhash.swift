// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaClient {
    func getRecentBlockhash() async throws -> String? {
        guard
            let slot = try await getBlockProduction().result?.context.slot,
            let blockhash = try await getBlock(slot).result?.blockhash
        else { return nil }
        return blockhash
    }
}
