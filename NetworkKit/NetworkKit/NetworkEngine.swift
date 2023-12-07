import Foundation

public final class NetworkEngine {

    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result< T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURl
        components.path = endpoint.path
        
        guard let url = components.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response != nil else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }

            DispatchQueue.main.async {
                var responseObject: T
                do {
                    responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }
        dataTask.resume()
    }
}

enum NetworkError: Error {
    case emptyResponse
    case invalidResponse
    case decodingError
}
