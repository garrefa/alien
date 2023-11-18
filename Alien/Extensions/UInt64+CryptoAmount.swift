// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

//extension UInt64 {
//    var lamportToDecimal: Double {
//        return Measurement<CryptoAmount>(
//            value: Double(self),
//            unit: .lamport
//        )
//        .converted(to: .solana)
//        .value
//    }
//
//    func solFormatted() -> String {
//        let number = NSNumber(value: lamportToDecimal)
//        let nf = NumberFormatter()
//        nf.minimumFractionDigits = 2
//        nf.maximumFractionDigits = 9
//        nf.numberStyle = .currency
//        nf.currencySymbol = "SOL"
//        return nf.string(from: number) ?? "--"
//    }
//
//    func lamportsFormatted() -> String {
//        let number = NSNumber(value: self)
//        let nf = NumberFormatter()
//        nf.minimumFractionDigits = 0
//        nf.maximumFractionDigits = 0
//        nf.usesGroupingSeparator = true
//        nf.numberStyle = .decimal
//        nf.currencySymbol = "lamports"
//        nf.format
//        return nf.string(from: number) ?? "--"
//    }
//}
