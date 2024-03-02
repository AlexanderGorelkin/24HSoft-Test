//
//  PhotoListModuleBuilder.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

import UIKit
class PhotoListModuleBuilder {
    static func build() -> PhotoListViewController {
        let interactor = PhotoListInteractor()
        let router = PhotoListRouter()
        let presenter = PhotoListPresenter(interactor: interactor, router: router)
        let viewController = PhotoListViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
