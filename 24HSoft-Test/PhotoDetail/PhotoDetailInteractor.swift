//
//  PhotoDetailInteractor.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

import Foundation
protocol PhotoDetailInteractorProtocol: AnyObject {
    var imageString: String { get }
    var username: String { get }
}
extension PhotoDetailInteractorProtocol {
    var imageURL: URL {
        return URL(string: imageString)!
    }
}
class PhotoDetailInteractor: PhotoDetailInteractorProtocol {
    weak var presenter: PhotoDetailPresenterProtocol?
    let username: String
    let imageString: String
    init(imageString: String, username: String) {
        self.username = username
        self.imageString = imageString
    }
}
