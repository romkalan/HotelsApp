//
//  ViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 04.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let urlAPI = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"

    private var hotel: Hotel?
    private var image: UIImage!
    private var imageURLs: [String] = []
    private let networkManager = NetworkManager.shared
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.layer.cornerRadius = 10
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return pageControl
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainInformationView = MainInformationView1()
    private let additionInformationView = AdditionInformationView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 15
        collectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: CollectionViewCell.reuseID
        )
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var chooseRoomButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont(name: "SF Pro Display", size: 16)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("К выбору номера", attributes: attributes)
        
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction
            { [unowned self] _ in chooseRoom() }
        )
        button.titleLabel?.textAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Отель"
        setupUI()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.alwaysBounceVertical = true
        fetchHotel()
    }
    
    private func chooseRoom() {
        let vc = RoomsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupHotelModel(_ hotel: Hotel) {
        self.hotel = hotel
        mainInformationView.configure(with: hotel)
        additionInformationView.configure(with: hotel)
        imageURLs = hotel.image_urls
        pageControl.numberOfPages = imageURLs.count
        collectionView.reloadData()
    }
    
    // MARK: - Networking
    private func fetchHotel() {
        networkManager.fetchData(Hotel.self, from: URL(string: urlAPI)) { [weak self] result in
            switch result {
            case .success(let hotel):
                DispatchQueue.main.async {
                    self?.setupHotelModel(hotel)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - SetupUI
private extension ViewController {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(mainInformationView)
        contentView.addSubview(additionInformationView)
        contentView.addSubview(chooseRoomButton)
    }
    
    func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        mainInformationView.translatesAutoresizingMaskIntoConstraints = false
        additionInformationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            collectionView.widthAnchor.constraint(equalToConstant: 343),
            collectionView.heightAnchor.constraint(equalToConstant: 257),
            
            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -8),
            
            mainInformationView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            mainInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainInformationView.heightAnchor.constraint(equalToConstant: 160),
            
            additionInformationView.topAnchor.constraint(equalTo: mainInformationView.bottomAnchor, constant: 8),
            additionInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            additionInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            additionInformationView.heightAnchor.constraint(equalToConstant: 428),
            
            chooseRoomButton.topAnchor.constraint(equalTo: additionInformationView.bottomAnchor, constant: 16),
            chooseRoomButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            chooseRoomButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            chooseRoomButton.heightAnchor.constraint(equalToConstant: 48),
            chooseRoomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.reuseID,
            for: indexPath
        ) as? CollectionViewCell else { return UICollectionViewCell() }
        
        let imageName = imageURLs[indexPath.row]
        cell.configure(imageName: imageName)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / collectionView.bounds.width)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
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



