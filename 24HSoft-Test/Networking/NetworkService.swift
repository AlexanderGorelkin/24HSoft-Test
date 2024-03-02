//
//  NetworkService.swift
//  24HSoft-Test
//
//  Created by Александр Горелкин on 01.03.2024.
//

import Foundation
import Alamofire
final class NetworkService {
    func fetchPhotoList(completion: @escaping (Result<PhotoList, NetworkError>) -> Void) {
        let params: [String: Any] = [
            "client_id": API.key
        ]
        fetchData(with: .fetchPhoto, params: params, completion: completion)
    }
    private func fetchData<T: Codable>(with route: Route, params: [String: Any], completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlString = URL(string: Route.baseUrl + route.description) else { return }
        AF.request(urlString, method: .get, parameters: params, headers: nil)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let data = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(data))
                    } catch {
                        completion(.failure(NetworkError.errorDecoding))
                        return
                    }
                case .failure(let error):
                    completion(.failure(NetworkError.serverError(error.localizedDescription)))
                }
            }
    }
}
