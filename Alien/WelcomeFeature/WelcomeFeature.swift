// Copyright © 2023 Area51 Brasil. All rights reserved.

import SwiftUI
import ComposableArchitecture
import WalletCore

struct WelcomeFeature: ReducerProtocol {
    struct State: Equatable {
        var wallet: AlienWallet?
        var recoveryMnemonic: String = ""

        static func == (
            lhs: WelcomeFeature.State,
            rhs: WelcomeFeature.State
        ) -> Bool {
            lhs.wallet?.mnemonic == rhs.wallet?.mnemonic &&
            lhs.recoveryMnemonic == rhs.recoveryMnemonic
        }
    }

    enum Action: Equatable {
        case createWalletButtonTapped
        case storeMnemonic(String?)
        case updateRecoveryMnemonic(String)
        case recoverWalletButtonTapped(mnemonic: String, passphrase: String?)
    }

    @Dependency(\.secureStorage) var secureStorage

    func reduce(
        into state: inout State,
        action: Action
    ) -> ComposableArchitecture.EffectTask<Action> {

        switch action {
        case .createWalletButtonTapped:
            state.recoveryMnemonic = ""
            let wallet = HDWallet(strength: 128, passphrase: "")
            state.wallet = wallet
            return .send(.storeMnemonic(wallet?.mnemonic))

        case .storeMnemonic(let mnemonic):
            secureStorage.value.store(key: .mnemonic, mnemonic)
            return .none

        case .recoverWalletButtonTapped(let mnemonic, let passphrase):
            state.recoveryMnemonic = ""
            let wallet = HDWallet(
                mnemonic: mnemonic,
                passphrase: passphrase ?? ""
            )
            state.wallet = wallet
            return .send(.storeMnemonic(wallet?.mnemonic))

        case .updateRecoveryMnemonic(let mnemonic):
            state.recoveryMnemonic = mnemonic
            return .none
        }
    }
}
