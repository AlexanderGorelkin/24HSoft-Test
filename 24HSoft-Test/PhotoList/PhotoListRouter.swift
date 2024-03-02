//
//  PhotoListRouter.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

protocol PhotoListRouterProtocol {
    func showDetailController(with url: String, and username: String)
    func showAlertController(with error: NetworkError)
}

class PhotoListRouter: PhotoListRouterProtocol {
    weak var viewController: PhotoListViewController?
    func showDetailController(with url: String, and username: String) {
        let vc = PhotoDetailModuleBuilder.build(with: url, username: username)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    func showAlertController(with error: NetworkError) {
        viewController?.showAlertController(with: error)
    }
}
