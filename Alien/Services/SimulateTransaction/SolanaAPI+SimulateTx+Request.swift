// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

extension SolanaAPI.SimulateTransaction {
    struct Request: Encodable {
        static func build(
            _ method: String,
            signedTx: String,
            sigVerify: Bool = true,
            replaceRecentBlockhash: Bool = false,
            minContextSlot: UInt64 = 0,
            accounts: [String]
        ) -> SolanaRequest<Params> {
            let extraParams = ExtraParams(
                sigVerify: sigVerify,
                replaceRecentBlockhash: replaceRecentBlockhash,
                minContextSlot: minContextSlot,
                accounts: Accounts(addresses: accounts)
            )

            let params = Params(
                signedTransaction: signedTx,
                params: extraParams
            )

            return SolanaRequest(
                method: "simulateTransaction",
                params: params
            )
        }
    }

    struct Accounts: Encodable {
        /// Base64 public keys related to the transactions
        /// the first is the one signing the transaction
        /// second is the receiver
        /// third (optional): 11111111111111111111111111111111
        let addresses: [String]
    }

    struct ExtraParams: Encodable {
        let sigVerify: Bool
        let replaceRecentBlockhash: Bool
        let minContextSlot: UInt64
        let accounts: Accounts
    }

    struct Params: Encodable {
        /// signed transaction base58 encoded
        let signedTransaction: String
        let params: ExtraParams

        func encode(to encoder: Encoder) throws {
            var container = encoder.unkeyedContainer()
            try container.encode(self.signedTransaction)
            try container.encode(self.params)
        }
    }
}
