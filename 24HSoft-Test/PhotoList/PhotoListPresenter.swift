//
//  PhotoListPresenter.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//


protocol PhotoListPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didTapCell(on indexPath: Int)
    func dataLoaded(with photoList: [PhotoListModel])
    func dataLoaded(with error: NetworkError)
}
class PhotoListPresenter {
    weak var view: PhotoListViewProtocol?
    var router: PhotoListRouterProtocol
    var interactor: PhotoListInteractorProtocol

    init(interactor: PhotoListInteractorProtocol, router: PhotoListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
extension PhotoListPresenter: PhotoListPresenterProtocol {
    func viewDidLoaded() {
        interactor.fetchPhotoList()
    }
    func didTapCell(on indexPath: Int) {
        let imageURL = interactor.photoList[indexPath].urls.regular
        let username = interactor.photoList[indexPath].user.username
        router.showDetailController(with: imageURL, and: username)
    }
    func dataLoaded(with photoList: PhotoList) {
        view?.reloadCollectionView(with: photoList)
    }
    func dataLoaded(with error: NetworkError) {
        router.showAlertController(with: error)
    }
    
}
