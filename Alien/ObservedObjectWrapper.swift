// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

class ObservedObjectWrapper<T>: ObservableObject {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}
