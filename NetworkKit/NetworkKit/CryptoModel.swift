import Foundation

public struct CryptoModel: Codable {
    let data: Crypto
}

struct Crypto: Codable {
    let marketData: MarketData
    let marketcap: Marketcap
    let allTimeHigh: AllTimeHigh
    let symbol: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case symbol, name, marketcap
        case marketData = "market_data"
        case allTimeHigh = "all_time_high"
    }
}

struct MarketData: Codable {
    let priceUsd: Double
    let percentChangeUsdLast24Hours: Double
    let percentChangeUsdLast1Hour: Double

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
        case percentChangeUsdLast1Hour = "percent_change_usd_last_1_hour"
    }
}

struct Marketcap: Codable {
    let rank: Int
}

struct AllTimeHigh: Codable {
    let price: Double
}

enum NameOfCrypto: String, CaseIterable {
    case btc      = "btc"
    case eth      = "eth"
    case tron     = "tron"
    case polkadot = "polkadot"
    case dogecoin = "dogecoin"
    case stellar  = "stellar"
    case cardano  = "cardano"
    case xrp      = "xrp"
    case luna = "luna"
    case tether = "tether"
}

enum SortState {
    case up
    case down
}
