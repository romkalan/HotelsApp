//
//  ViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 04.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private let urlAPI = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    private var hotel: Hotel?
    private var image: UIImage!
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
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(contentView)
    
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(mainInformationView)
        contentView.addSubview(additionInformationView)
        contentView.addSubview(chooseRoomButton)
        
        setupUI()
        fetchHotel()
    }
    
    private func chooseRoom() {
        let vc = RoomsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Networking
    private func fetchHotel() {
        networkManager.fetchData(Hotel.self, from: URL(string: urlAPI)) { [weak self] result in
            switch result {
            case .success(let hotel):
                self?.mainInformationView.configure(with: hotel)
                self?.additionInformationView.configure(with: hotel)
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - SetupUI
extension ViewController {
    private func setupUI() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupCollectionViewConstraints()
        setupPageControlConstraints()
        setupMainInformationViewConstraints()
        setupAdditionInformationViewConstraints()
        setupChooseRoomButton()
    }
    
    private func setupScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height)
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
            contentView.heightAnchor.constraint(equalToConstant: view.frame.size.height + 80)
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
            mainInformationView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    private func setupAdditionInformationViewConstraints() {
        additionInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionInformationView.topAnchor.constraint(equalTo: mainInformationView.bottomAnchor, constant: 8),
            additionInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            additionInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            additionInformationView.heightAnchor.constraint(equalToConstant: 428)
        ])
    }
    
    private func setupChooseRoomButton() {
        NSLayoutConstraint.activate([
            chooseRoomButton.topAnchor.constraint(equalTo: additionInformationView.bottomAnchor, constant: 16),
            chooseRoomButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            chooseRoomButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            chooseRoomButton.heightAnchor.constraint(equalToConstant: 48),
        ])
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
        
        cell.configure(image: UIImage(named: "mainImage"))
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



