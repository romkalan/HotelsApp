//
//  ViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 04.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let urlAPI = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    private var hotels: [Hotel] = []
    private let networkManager = NetworkManager.shared
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.layer.cornerRadius = 10
        return pageControl
    }()
    
    let mainInformationView: MainInformationView = {
        let mainInfoView = MainInformationView()
        mainInfoView.layer.cornerRadius = 15
        return mainInfoView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Отель"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(mainInformationView)
        
        setupUI()
        fetchHotel()
    }
    
    private func fetchHotel() {
        networkManager.fetchData(Hotel.self, from: URL(string: urlAPI)) { [weak self] result in
            switch result {
            case .success(let hotel):
                self?.hotels.append(hotel)
                print(hotel)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: SetupUI
extension ViewController {
    private func setupUI() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupCollectionViewConstraints()
        setupPageControlConstraints()
        setupMainInformationViewConstraints()
    }
    
    private func setupScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    private func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    private func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            collectionView.widthAnchor.constraint(equalToConstant: 343),
            collectionView.heightAnchor.constraint(equalToConstant: 257)
        ])
    }
    private func setupPageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -8),
        ])
    }
    private func setupMainInformationViewConstraints() {
        mainInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainInformationView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            mainInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainInformationView.widthAnchor.constraint(equalToConstant: 343),
            mainInformationView.heightAnchor.constraint(equalToConstant: 257)
        ])
//        mainInformationView.rateLabel.textColor = .green
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.reuseID,
            for: indexPath
        ) as? CollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .cyan
//        let hotel = hotels[indexPath.row]
//        cell.image.image = UIImage(named: hotel.image)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / collectionView.bounds.width)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: contentView.frame.size.width,
            height: contentView.frame.size.height
        )
    }
}


