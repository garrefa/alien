// Copyright © 2023 Area51 Brasil. All rights reserved.

import SwiftUI
import ComposableArchitecture

struct WelcomeView: View {
    let store: StoreOf<WelcomeFeature>
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ZStack {
                    Color.background.ignoresSafeArea()
                    VStack(spacing: 18) {
                        Spacer()

//                        TextField(
//                            "Enter the mnemonic to recover your wallet",
//                            text: viewStore.binding(
//                                get: \.recoveryMnemonic,
//                                send: ContentFeature.Action.updateRecoveryMnemonic),
//                            axis: .vertical
//                        )
//                        .textFieldStyle(.roundedBorder)


                        VStack(spacing: 16) {
                            Button("Create new wallet") {
                                viewStore.send(.createWalletButtonTapped)
                            }
                            .foregroundColor(.glow)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .clipShape(Capsule())

                            Button("Recover your wallet") {
                                viewStore.send(.recoverWalletButtonTapped(
                                    mnemonic: viewStore.recoveryMnemonic,
                                    passphrase: nil
                                ))
                            }
                            .foregroundColor(Color.Text.primary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .clipShape(Capsule())
                        }
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.bottom, 36)

                        HStack {
                            Spacer()
                                .frame(maxWidth: .infinity)
                            Toggle("Dark Mode", isOn: $isDarkMode)
                        }
                    }
                    .padding()
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            TitleView()
                        }
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(store: .init(
            initialState: WelcomeFeature.State(),
            reducer: WelcomeFeature()
        ))
    }
}
#endif
