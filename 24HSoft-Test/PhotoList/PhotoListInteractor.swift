//
//  PhotoListInteractor.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

protocol PhotoListInteractorProtocol: AnyObject {
    var photoList: PhotoList { get }
    func fetchPhotoList()
}
class PhotoListInteractor: PhotoListInteractorProtocol {
    weak var presenter: PhotoListPresenterProtocol?
    var photoList: PhotoList = []
    private let networkService = NetworkService()
    func fetchPhotoList() {
        networkService.fetchPhotoList { [weak self] result in
            switch result {
            case .success(let data):
                self?.photoList = data
                self?.presenter?.dataLoaded(with: data)
            case .failure(let error):
                self?.presenter?.dataLoaded(with: error)
            }
        }
    }
}
