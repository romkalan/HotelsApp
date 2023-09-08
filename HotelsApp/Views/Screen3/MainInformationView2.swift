//
//  MainInformationView2.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import UIKit

final class MainInformationView2: UIView {
    
    private let urlAPI = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    private var hotels: [Hotel] = []
    private let networkManager = NetworkManager.shared
    
    private let ratingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 255, green: 199, blue: 0, alpha: 0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let starIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "star")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "5 Превосходно"
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(named: "customYellow")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hotelNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Steigenberger Makadi"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 14)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.attributedTitle = AttributedString("Madinat Makadi, Safaga Road, Makadi Bay, Египет", attributes: attributes)
        
        let button = UIButton(configuration: buttonConfiguration)
        button.titleLabel?.textAlignment = .left
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchHotel()
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchHotel() {
        networkManager.fetchData(Hotel.self, from: URL(string: urlAPI)) { [weak self] result in
            switch result {
            case .success(let hotel):
                self?.hotels.append(hotel)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: SetupUI with Constraints
extension MainInformationView2 {
    private func setupUI() {
        self.addSubview(ratingView)
        ratingView.addSubview(starIcon)
        ratingView.addSubview(rateLabel)
        
        self.addSubview(hotelNameLabel)
        self.addSubview(addressButton)
        
        NSLayoutConstraint.activate([
            ratingView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            ratingView.leftAnchor.constraint(equalTo: self.leftAnchor),
            ratingView.widthAnchor.constraint(equalToConstant: 149),
            ratingView.heightAnchor.constraint(equalToConstant: 29),
            
            starIcon.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            starIcon.leftAnchor.constraint(equalTo: ratingView.leftAnchor, constant: 4),
            starIcon.widthAnchor.constraint(equalToConstant: 15),
            starIcon.heightAnchor.constraint(equalToConstant: 15),
            
            rateLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            rateLabel.leftAnchor.constraint(equalTo: starIcon.rightAnchor, constant: 4),
            rateLabel.heightAnchor.constraint(equalToConstant: 15),
            
            hotelNameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 10),
            hotelNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            addressButton.topAnchor.constraint(equalTo: hotelNameLabel.bottomAnchor, constant: 10),
            addressButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -12),
            
        ])
    }
}

