// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaAPI {
    struct SimulateTransaction {}
}

extension SolanaAPI {
    func simulate(
        _ signedTx: String,
        sender: String,
        recepient: String,
        debug: Bool = false
    ) async throws -> Bool {
        let response = try await internal_simulateTransaction(
            signedTx,
            accounts: [sender, recepient],
            debug: debug
        )
        guard let result = response.result else { return false }
        return response.error == nil && result.value.err == nil
    }

    private func internal_simulateTransaction(
        _ signedTx: String,
        accounts: [String],
        debug: Bool = false
    ) async throws -> SimulateTransaction.Response {
        try await client.post(
            SimulateTransaction.Request.build(
                "simulateTransaction",
                signedTx: signedTx,
                accounts: accounts
            ),
            debug: debug
        )
    }
}
