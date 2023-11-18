// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

/// Helpful debug string builders
extension String {
    /// Builds a string of repeating dashes
    static func divider(
        repeating: Character = "-",
        count: Int = 80
    ) -> String {
        String(repeating: repeating, count: count)
    }
}

///> Title:
///--------------------------------------------------------------------------------
func printHeader(_ title: String, divider: Bool = true) {
    let text = "\n> \(title.capitalized):\n" + (divider ? String.divider() : "")
    print(text)
}
