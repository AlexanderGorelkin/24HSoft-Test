//
//  PhotoListModel.swift
//  24HSoft-Test
//
//  Created by Александр Горелкин on 01.03.2024.
//

import Foundation
typealias PhotoList = [PhotoListModel]
struct PhotoListModel: Codable {
    let color: String
    let description: String?
    let altDescription: String
    let urls: Urls
    let likes: Int
    let user: User
    enum CodingKeys: String, CodingKey {
        case  color
        case description
        case altDescription = "alt_description"
        case urls, likes
        case user
    }
}
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
struct User: Codable {
    let username, name, firstName: String
    enum CodingKeys: String, CodingKey {
           case username, name
           case firstName = "first_name"
       }
}
