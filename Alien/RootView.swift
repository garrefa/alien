// Copyright © 2023 Area51 Brasil. All rights reserved.

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @EnvironmentObject
    private var storage: ObservedStorage
    var solanaClient = SolanaClient()

    @State var wallet: AlienWallet?
    @State private var isLoaded = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            if isLoaded {
                if let wallet {
                    DashboardView(wallet: wallet)
                } else {
                    WelcomeView(
                        store: Store(
                            initialState: WelcomeFeature.State(wallet: wallet),
                            reducer: WelcomeFeature()._printChanges()
                        )
                    )
                }
            } else {
                VStack {
                    Spacer()
                    TitleView()
                    Spacer()
                }
            }
        }.task {
//            Task {
//                try await Task.sleep(nanoseconds: 1_000_000_000)
//                if let mnemonic = storage.value.recover(key: .mnemonic),
//                   let wallet: AlienWallet = WalletFactory.wallet(from: mnemonic)
//                {
//                    self.wallet = wallet
//                }
//                withAnimation {
//                    self.isLoaded = true
//                }
//            }
            do {
//                let health = try await solanaClient.getHealth()
//                print(health)
//
//                let version = try await solanaClient.getVersion()
//                print("\n\(version)")
//
//                let pubKey = "4bq46im9W4VjuXQ9ftuqJkzm8bAbtay1nEvwxg15pZ9V"
//                let accountInfo = try await solanaClient.getAccountInfo(pubKey)
//                print("\n\(accountInfo)")

                if let mnemonic = storage.value.recover(key: .mnemonic),
                    let wallet: AlienWallet = WalletFactory.wallet(from: mnemonic),
                    let blockhash = try await solanaClient.getRecentBlockhash()
                {
                    let destination = "HPU6qz4ixcAicQdDTDRY6AoTkv37Pw2te9U4p9h3SYU2"
                    let privateKey = wallet.getKeyForCoin(coin: .solana)
                    let source = wallet.getAddressForCoin(coin: .solana)
                    print("\nsource:\n\t\(source)")

                    let output = solanaClient
                        .createTransfer(
                            destination,
                            lamports: 1_000_000_000_000
                        )
                        .signedMessage(
                            privateKey.data,
                            recentBlockhash: blockhash
                        )
                    print("\nsignedTx:\n\t\(output)")
                    print("\nblockhash:\n\t\(blockhash)")

                    if try await  SolanaAPI().simulate(
                        output.encoded,
                        sender: source,
                        recepient: destination,
                        debug: true
                    ) {
                        print("transaction sent")
                    }
                }
            }
            catch {
                print("\n")
                debugPrint(error)
            }
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif

struct DashboardView: View {
    @State var wallet: AlienWallet
    @State private var showingSheet = false
    @State var solanaAddress: String?
    @State var cosmosAddress: String?
    @State var nearAddress: String?
    @State var polygonAddress: String?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                if let solanaAddress {
                    Text("SOL Pubkey")
                    Text(solanaAddress)
                        .textSelection(.enabled)
                }

                if let cosmosAddress {
                    Text("Cosmos Pubkey")
                    Text(cosmosAddress)
                        .textSelection(.enabled)
                }

                if let nearAddress {
                    Text("Near Pubkey")
                    Text(nearAddress)
                        .textSelection(.enabled)
                }

                if let polygonAddress {
                    Text("Polygon Pubkey")
                    Text(polygonAddress)
                        .textSelection(.enabled)
                }

                Button("Show mnemonic") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    MnemonicView(store: Store(
                        initialState: MnemonicFeature.State(wallet: wallet),
                        reducer: MnemonicFeature())
                    )
                }

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TitleView()
                }
            }
            .task {
                solanaAddress = wallet.getAddressForCoin(coin: .solana)
                cosmosAddress = wallet.getAddressForCoin(coin: .cosmos)
                nearAddress = wallet.getAddressForCoin(coin: .near)
                polygonAddress = wallet.getAddressForCoin(coin: .polygon)
            }
        }
    }
}
