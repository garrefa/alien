// Copyright © 2023 Area51 Brasil. All rights reserved.

import SwiftUI
import ComposableArchitecture

struct MnemonicFeature: ReducerProtocol {
    
    struct State: Equatable {
        var wallet: AlienWallet

        static func == (
            lhs: MnemonicFeature.State,
            rhs: MnemonicFeature.State
        ) -> Bool {
            lhs.wallet.mnemonic == rhs.wallet.mnemonic
        }
    }

    enum Action: Equatable {
    }

    func reduce(
        into state: inout State,
        action: Action
    ) -> ComposableArchitecture.EffectTask<Action> {
    }
}

struct MnemonicView: View {
    let store: StoreOf<MnemonicFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0.wallet.mnemonic }) { viewStore in
            VStack(spacing: 12) {
                Text("Mnemonic")
                    .font(.title2)

                let rows = splitMnemonic(viewStore.state)
                Grid(alignment: .topLeading,
                     horizontalSpacing: 36,
                     verticalSpacing: 8
                ) {
                    ForEach(rows.indices, id: \.self) { index in
                        GridRow {
                            Text(rows[index].0)
                            Text(rows[index].1)
                        }
                    }
                }
            }
        }
    }

    func splitMnemonic(_ mnemonic: String) -> [(String, String)] {
        var words: [String] = mnemonic
            .split(separator: " ")
            .map { String($0) }
            .enumerated()
            .map ({ index, word in
                (index < 9 ? "0" : "") + "\(index + 1) - \(word)"
            })
        // handle mnemonics with odd number of words
        if words.count % 2 != 0 {
            words.append("")
        }
        let chunks = words.chunked(into: words.count/2)
        return Array(zip(chunks[0], chunks[1]))
    }
}

#if DEBUG
import WalletCore

struct MnemonicView_Previews: PreviewProvider, View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()

            VStack {
                Spacer()

                MnemonicView(
                    store: Store(
                        initialState: .init(wallet: HDWallet.preview),
                        reducer: MnemonicFeature()
                    )
                )

                Spacer()

                HStack {
                    Spacer()
                        .frame(maxWidth: .infinity)
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
            }
            .padding()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    static var previews: some View {
        MnemonicView_Previews()
    }
}
#endif
