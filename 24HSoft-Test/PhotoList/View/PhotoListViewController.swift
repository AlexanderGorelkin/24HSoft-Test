//
//  PhotoListViewController.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

import UIKit

protocol PhotoListViewProtocol: AnyObject {
    func reloadCollectionView(with data: PhotoList)
    func showAlertController(with error: NetworkError)
    func startLoader()
    func stopLoader()
}
class PhotoListViewController: UIViewController {
    // MARK: - Public
    var presenter: PhotoListPresenterProtocol?
    // MARK:  Private
    private var photoList: PhotoList = []
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(PhotoListCell.self, forCellWithReuseIdentifier: PhotoListCell.identifier)
        return collectionView
    }()
    private lazy var loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addView(photoCollectionView)
        photoCollectionView.setSimpleConstraints()
    }
}
// MARK: - Private functions
private extension PhotoListViewController {
    func initialize() {
        presenter?.viewDidLoaded()
    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - PhotoListViewProtocol
extension PhotoListViewController: PhotoListViewProtocol {
    func startLoader() {
        view.addView(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.startAnimating()
    }
    func stopLoader() {
        loader.stopAnimating()
    }
    func showAlertController(with error: NetworkError) {
        let alertController = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    func reloadCollectionView(with data: PhotoList) {
        photoList = data
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
}
extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didTapCell(on: indexPath.row)
    }
}
extension PhotoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCell.identifier, for: indexPath) as! PhotoListCell
        cell.setupCell(with: photoList[indexPath.row])
        return cell
    }
}
