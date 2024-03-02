//
//  Route.swift
//  24HSoft-Test
//
//  Created by Александр Горелкин on 01.03.2024.
//

import Foundation
enum Route {
    static let baseUrl = "https://api.unsplash.com"
    case fetchPhoto
    var description: String {
        switch self {
        case .fetchPhoto:
            return "/photos"
        }
    }
}
