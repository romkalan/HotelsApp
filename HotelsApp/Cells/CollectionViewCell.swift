//
//  CollectionViewCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 05.09.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "cell"
    var image = UIImageView()
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellUI() {
        self.contentView.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
                
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
}
