// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation
import KeychainAccess

typealias ObservedStorage = ObservedObjectWrapper<Storage>

struct Storage {
    var recover: (_ key: String) -> String?
    var store: (_ key: String, _ value: String?) -> Void
}

enum StorageKey: String {
    case mnemonic
}

struct StorageFactory {
    private static let serviceId = "br.com.area51.alienwllt"

    static var keychain: ObservedStorage {
        ObservedStorage(
            Storage { key in
                let keychain = Keychain(service: serviceId)
                return keychain[key]
            } store: { key, value in
                let keychain = Keychain(service: serviceId)
                keychain[string: key] = value
            }
        )
    }
}

extension Storage {
    func recover(key: StorageKey) -> String? {
        recover(key.rawValue)
    }

    func store(key: StorageKey, _ value: String?) -> Void {
        store(key.rawValue, value)
    }
}

import ComposableArchitecture

private enum StorageDependencyKey: DependencyKey {
    static var liveValue = StorageFactory.keychain
}

extension DependencyValues {
    var secureStorage: ObservedStorage {
        get { self[StorageDependencyKey.self] }
        set { self[StorageDependencyKey.self] = newValue }
    }
}
