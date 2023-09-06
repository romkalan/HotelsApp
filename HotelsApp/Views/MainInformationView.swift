//
//  MainInformationView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 05.09.2023.
//

import UIKit

final class MainInformationView: UIView {
    
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
    
    private let rateLabel: UILabel = {
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
    
    private let hotelPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "от 134 673 ₽"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let forWayWithFlyLabel: UILabel = {
        let label = UILabel()
        label.text = "за тур с перелётом"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(named: "customGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SetupUI with Constraints
extension MainInformationView {
    private func setupUI() {
        self.addSubview(ratingView)
        ratingView.addSubview(starIcon)
        ratingView.addSubview(rateLabel)
        self.addSubview(hotelNameLabel)
        self.addSubview(addressButton)
        self.addSubview(hotelPriceLabel)
        self.addSubview(forWayWithFlyLabel)
        
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
            
            hotelPriceLabel.topAnchor.constraint(equalTo: addressButton.bottomAnchor, constant: 10),
            hotelPriceLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            forWayWithFlyLabel.centerYAnchor.constraint(equalTo: hotelPriceLabel.centerYAnchor),
            forWayWithFlyLabel.leftAnchor.constraint(equalTo: hotelPriceLabel.rightAnchor, constant: 8),
            
        ])
    }
}
