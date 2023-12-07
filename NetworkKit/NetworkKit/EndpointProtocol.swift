import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURl: String { get }
    var path: String { get }
    var method: String { get }
}
