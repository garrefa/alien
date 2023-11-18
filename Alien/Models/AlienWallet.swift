// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation
import WalletCore

protocol AlienWallet {
    var mnemonic: String { get }
    
    func getAddressForCoin(coin: CoinType) -> String
    func getKeyForCoin(coin: CoinType) -> PrivateKey
}

struct WalletFactory {
    static func wallet(from mnemonic: String) -> HDWallet? {
        HDWallet(mnemonic: mnemonic, passphrase: "")
    }
}

extension HDWallet: AlienWallet {}
