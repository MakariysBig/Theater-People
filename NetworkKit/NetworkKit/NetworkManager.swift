import Foundation

//MARK: - NetworkProtocol

public protocol NetworkProtocol {
    func getCrypto(pair: String, completion: @escaping (Result< CryptoModel, Error >) -> Void)
}

//MARK: - NetworkManager

public final class NetworkManager: NetworkProtocol {
    private let networkEngine: NetworkEngine = NetworkEngine()

    public init() {}
//    public init(networkEngine: NetworkEngine = NetworkEngine()) {
//        self.networkEngine = networkEngine
//    }
    
    public func getCrypto(pair: String, completion: @escaping (Result< CryptoModel, Error >) -> Void) {
        networkEngine.request(endpoint: CryptoEndpoint.getData(pair: pair), completion: completion)
    }
}
