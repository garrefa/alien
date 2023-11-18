// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

struct SolanaError: Decodable, CustomStringConvertible {
    let message: String
    let code: Int

    var description: String {
        "\(code): \(message)"
    }
}
