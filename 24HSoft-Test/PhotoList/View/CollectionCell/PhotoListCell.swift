//
//  PhotoListCell.swift
//  24HSoft-Test
//
//  Created by Александр Горелкин on 01.03.2024.
//

import UIKit
import Kingfisher
final class PhotoListCell: UICollectionViewCell {
    static let identifier = String(describing: PhotoListCell.self)
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "likesLabel"
         return label
    }()
    private lazy var desriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.text = "desriptionLabel"
         return label
    }()
    private lazy var labelsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.addArrangedSubview(likesLabel)
        stackView.addArrangedSubview(desriptionLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayer() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 100, height: 100)
    }
    private func setupViews() {
        addView(imageView)
        addView(labelsStackView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            labelsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
    func setupCell(with model: PhotoListModel) {
        if let url = URL(string: model.urls.thumb){
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: url,
                options: [
                    .cacheOriginalImage
                ])
        }
        if let description = model.description {
            desriptionLabel.text = description
        } else {
            desriptionLabel.text = model.altDescription
        }
        desriptionLabel.textColor = UIColor(hexString: model.color)
        likesLabel.text = "Количество лайков - \(model.likes)"
    }
}
