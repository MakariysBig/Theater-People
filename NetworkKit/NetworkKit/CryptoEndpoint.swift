import Foundation

enum CryptoEndpoint: Endpoint {
    case getData(pair: String)
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURl: String {
        switch self {
        default:
            return "data.messari.io"
        }
    }

    var path: String {
        switch self {
        case .getData(let pair):
            return "/api/v1/assets/\(pair)/metrics"
        }
    }

    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
}
