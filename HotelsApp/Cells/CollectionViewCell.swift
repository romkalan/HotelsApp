//
//  CollectionViewCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 05.09.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "cell"
    private var imageURLs: [String] = []
    
    private var image: UIImage? {
        didSet {
            imageView.image = image
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    private var imageView = UIImageView()
    
    private let networkManager = NetworkManager.shared
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String) {
        networkManager.fetchImage(from: imageName) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

// MARK: - SetupUI
private extension CollectionViewCell {
    func setupUI() {
        addViews()
        imageView.contentMode = .scaleAspectFill
        setConstraints()
    }
    
    func addViews() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(activityIndicator)
    }
    
    func setConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}


