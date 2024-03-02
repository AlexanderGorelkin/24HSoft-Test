//
//  PhotoDetailModuleBuilder.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

import UIKit

class PhotoDetailModuleBuilder {
    static func build(with photoUrl: String, username: String) -> PhotoDetailViewController {
        let interactor = PhotoDetailInteractor(imageString: photoUrl, username: username)
        let router = PhotoDetailRouter()
        let presenter = PhotoDetailPresenter(interactor: interactor, router: router)
        let viewController = PhotoDetailViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
