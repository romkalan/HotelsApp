//
//  RoomTableViewCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

final class RoomTableViewCell: UITableViewCell {
    static let reuseID = "room"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(
            frame: self.contentView.frame,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 30
        collectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.reuseID
        )
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.layer.cornerRadius = 10
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var aboutRoomLabel: UILabel = {
        let label = UILabel()
        label.text = "Стандартный с видом на бассейн или сад"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var advantage1: UILabel = {
        setupUIWith(text: "Все включено")
    }()
    
    private lazy var advantage2: UILabel = {
        setupUIWith(text: "Кондиционер")
    }()
    
    private lazy var detailsInfoButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont(name: "SF Pro Display", size: 16)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Подробнее о номере   〉", attributes: attributes)
        buttonConfiguration.baseBackgroundColor = UIColor(named: "blueButtonColor")
        buttonConfiguration.baseForegroundColor = .systemBlue
        
        let button = UIButton(configuration: buttonConfiguration)
        button.titleLabel?.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var roomPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "от 186 600 ₽"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var countOfNightsLabel: UILabel = {
        let label = UILabel()
        label.text = "за 7 ночей с перелетом"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(named: "customGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var detailRoomButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont(name: "SF Pro Display", size: 16)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Выбрать номер", attributes: attributes)
        
        let button = UIButton(configuration: buttonConfiguration)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUIWith(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(named: "grayText")
        label.backgroundColor = UIColor(named: "backgroundGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func configure(with data: Room) {
        aboutRoomLabel.text = data.name
        advantage1.text = data.peculiarities[0]
        advantage2.text = data.peculiarities[1]
        roomPriceLabel.text = "От " + String(data.price) + " ₽"
        countOfNightsLabel.text = data.price_per
    }
}

// MARK: - NSLayoutConstraint
private extension RoomTableViewCell {
    func setupUI() {
        add(views:
                collectionView, pageControl, aboutRoomLabel, advantage1, advantage2,
                detailsInfoButton, roomPriceLabel, countOfNightsLabel, detailRoomButton
        )
        setConstraints()
    }
    
    func add(views: UIView...) {
        views.forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            collectionView.widthAnchor.constraint(equalToConstant: 343),
            collectionView.heightAnchor.constraint(equalToConstant: 257),
            
            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -8),
            
            aboutRoomLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            aboutRoomLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            aboutRoomLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            advantage1.topAnchor.constraint(equalTo: aboutRoomLabel.bottomAnchor, constant: 24),
            advantage1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            
            advantage2.topAnchor.constraint(equalTo: aboutRoomLabel.bottomAnchor, constant: 24),
            advantage2.leftAnchor.constraint(equalTo: advantage1.rightAnchor, constant: 24),
            
            detailsInfoButton.topAnchor.constraint(equalTo: advantage1.bottomAnchor, constant: 16),
            detailsInfoButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            detailsInfoButton.heightAnchor.constraint(equalToConstant: 29),
            
            roomPriceLabel.topAnchor.constraint(equalTo: detailsInfoButton.bottomAnchor, constant: 16),
            roomPriceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            countOfNightsLabel.centerYAnchor.constraint(equalTo: roomPriceLabel.centerYAnchor),
            countOfNightsLabel.leftAnchor.constraint(equalTo: roomPriceLabel.rightAnchor, constant: 16),
            
            detailRoomButton.topAnchor.constraint(equalTo: roomPriceLabel.bottomAnchor, constant: 16),
            detailRoomButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            detailRoomButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            detailRoomButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RoomTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.reuseID,
            for: indexPath
        ) as? CollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row == 0 {
            cell.configure(image: UIImage(named: "room1"))
        } else if indexPath.row == 1 {
            cell.configure(image: UIImage(named: "room2"))
        } else {
            cell.configure(image: UIImage(named: "room3"))
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / collectionView.bounds.width)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RoomTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 10, height: frameSize.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
