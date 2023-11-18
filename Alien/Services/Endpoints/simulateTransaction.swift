// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation
import WalletCore

extension SolanaBlockchainClient {
    func createTransfer(
        _ destination: String,
        lamports: UInt64,
        memo: String = ""
    ) -> SolanaTransfer {
        var transfer = SolanaTransfer()
        transfer.recipient = destination
        transfer.value = lamports
        return transfer
    }
}

extension SolanaTransfer {
    func signedMessage(
        _ privateKey: Data,
        recentBlockhash: String
    ) -> SolanaSigningOutput {
        var input = SolanaSigningInput()
        input.privateKey = privateKey
        input.recentBlockhash = recentBlockhash
        input.transferTransaction = self
        let output: SolanaSigningOutput = AnySigner.sign(
            input: input,
            coin: .solana
        )
        return output
    }
}
