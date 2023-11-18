// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

enum CryptoSymbol: String {
    case SOL
    case lamports

    var minimumFractionDigits: Int {
        switch self {
        case .lamports:
            return 0
        default:
            return 2
        }
    }

    var maximumFractionDigits: Int {
        switch self {
        case .lamports:
            return 0
        default:
            return 9
        }
    }
}

final class CryptoAmount: Dimension {
    static let solana = CryptoAmount(
        symbol: "SOL",
        converter: UnitConverterLinear(coefficient: 1.0)
    )

    static let lamports = CryptoAmount(
        symbol: "lamports",
        converter: UnitConverterLinear(coefficient: 1/1_000_000_000)
    )

    override class func baseUnit() -> CryptoAmount {
        return solana
    }
}

extension Measurement<CryptoAmount> {
    var formattedString: String {
        let number = NSNumber(value: value)
        let nf = NumberFormatter()
        if let symbol = CryptoSymbol(rawValue: unit.symbol) {
            nf.minimumFractionDigits = symbol.minimumFractionDigits
            nf.maximumFractionDigits = symbol.maximumFractionDigits
            nf.numberStyle = .decimal
            let formattedValue = nf.string(from: number) ?? "Nan"
            return "\(formattedValue) \(symbol)"
        }
        return "--"
    }
}
