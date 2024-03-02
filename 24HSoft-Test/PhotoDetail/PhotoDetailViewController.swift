//
//  PhotoDetailViewController.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 01.03.2024
//

import UIKit

protocol PhotoDetailViewProtocol: AnyObject {
    func showImage(imageURL: URL)
    func setTitle(title: String)
    func popToRoot()
}
class PhotoDetailViewController: UIViewController {
    // MARK: - Public
    var presenter: PhotoDetailPresenterProtocol?
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
        setupBackButton()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addView(imageView)
        imageView.setSimpleConstraints()
    }
}

// MARK: - Private functions
private extension PhotoDetailViewController {
    func initialize() {
        presenter?.viewDidLoaded()
    }
    func setupBackButton() {
        var conf = UIButton.Configuration.tinted()
        conf.image = UIImage(systemName: "chevron.backward")
        let button = UIButton(configuration: conf)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.popToRoot()
        }), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
}

// MARK: - PhotoDetailViewProtocol
extension PhotoDetailViewController: PhotoDetailViewProtocol {
    func showImage(imageURL: URL) {
        imageView.kf.setImage(with: imageURL)
    }
    func setTitle(title: String) {
        self.title = title
    }
    func popToRoot() {
        presenter?.popToRoot()
    }
}

