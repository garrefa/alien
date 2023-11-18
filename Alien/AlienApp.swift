// Copyright © 2023 Area51 Brasil. All rights reserved.

import SwiftUI

@main
struct AlienApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(StorageFactory.keychain)
        }
    }
}
