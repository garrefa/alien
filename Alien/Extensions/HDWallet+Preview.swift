// Copyright © 2023 Area51 Brasil. All rights reserved.

#if DEBUG
import WalletCore

extension HDWallet {
    static let preview = HDWallet(
        mnemonic: "ripple scissors kick mammal hire column " +
        "oak again sun offer wealth tomorrow wagon turn fatal",
        passphrase: ""
    )!
}
#endif

