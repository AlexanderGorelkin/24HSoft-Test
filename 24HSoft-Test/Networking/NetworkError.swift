//
//  NetworkError.swift
//  24HSoft-Test
//
//  Created by Александр Горелкин on 02.03.2024.
//

import Foundation
enum NetworkError: LocalizedError {
    case errorDecoding
    case serverError(String)
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Запрос не может быть расшифрован"
        case .serverError(let error):
            return error
        }
    }
}
