// Copyright © 2023 Area51 Brasil. All rights reserved.

import Foundation

struct SolanaBlockchainClient: BlockchainClient {
    func post<T: Decodable>(
        _ data: Encodable,
        debug: Bool
    ) async throws -> T {
        if debug {
            printHeader(#function, divider: false)
        }
        let url = URL(string: "https://solana-devnet.g.alchemy.com/v2/MtjDu-CqjjwDWYm1OJIQthamdpq02hFT")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let httpBody = try JSONEncoder().encode(data)
        request.httpBody = httpBody
        if debug {
            printHeader("request")
            let stringBody = httpBody.prettyPrintedJSONString
            debugPrint(stringBody ?? "request is not a String")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (result, _) = try await URLSession.shared.data(for: request)
        if debug {
            printHeader("response")
            let stringResponse = result.prettyPrintedJSONString
            debugPrint(stringResponse ?? "response is not a String")
        }
        do {
            return try JSONDecoder().decode(T.self, from: result)
        }
        catch {
            if debug {
                printHeader("error")
                debugPrint(error)
            }
            throw error
        }
    }
}
