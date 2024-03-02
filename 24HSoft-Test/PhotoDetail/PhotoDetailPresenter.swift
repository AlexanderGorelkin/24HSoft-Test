//
//  PhotoDetailPresenter.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

protocol PhotoDetailPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func popToRoot()
}
class PhotoDetailPresenter {
    weak var view: PhotoDetailViewProtocol?
    var router: PhotoDetailRouterProtocol
    var interactor: PhotoDetailInteractorProtocol

    init(interactor: PhotoDetailInteractorProtocol, router: PhotoDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
extension PhotoDetailPresenter: PhotoDetailPresenterProtocol {
    func viewDidLoaded() {
        let imageURL = interactor.imageURL
        let title = interactor.username
        view?.showImage(imageURL: imageURL)
        view?.setTitle(title: title)
    }
    func popToRoot() {
        router.popToRoot()
    }
}
