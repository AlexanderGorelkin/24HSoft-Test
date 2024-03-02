//
//  PhotoDetailRouter.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

protocol PhotoDetailRouterProtocol {
    func popToRoot()
}

class PhotoDetailRouter: PhotoDetailRouterProtocol {
    weak var viewController: PhotoDetailViewController?
    func popToRoot() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
