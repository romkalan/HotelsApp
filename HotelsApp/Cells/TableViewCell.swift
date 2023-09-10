//
//  TableViewCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    static let reuseID = "row"
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emoji-happy")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainLabel = UILabel(
        text: "",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 16),
        alignment: .left
    )
    
    private let secondaryLabel = UILabel(
        text: "",
        textColor: UIColor(named: "grayText"),
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 14),
        alignment: .left
    )
    
    private let nextIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "nextIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with image: UIImage, and text: String, and secondaryText: String) {
        self.image.image = image
        self.mainLabel.text = text
        self.secondaryLabel.text = secondaryText
    }
}
private extension TableViewCell {
    
    func setupUI() {
        add(views: image, mainLabel, secondaryLabel, nextIcon)
        setConstraints()
    }
    
    func add(views: UIView...) {
        views.forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24),
            
            mainLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16),
            mainLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            
            secondaryLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            secondaryLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            secondaryLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16),
            secondaryLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            
            nextIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            nextIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nextIcon.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            nextIcon.widthAnchor.constraint(equalToConstant: 24),
            nextIcon.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

