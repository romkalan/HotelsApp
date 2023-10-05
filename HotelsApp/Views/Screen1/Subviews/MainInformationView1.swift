//
//  MainInformationView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 05.09.2023.
//

import UIKit

final class MainInformationView1: UIView {
    
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
    
    private let rateLabel = UILabel(
        text: "5 Превосходно",
        textColor: UIColor(named: "customYellow"),
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 16),
        alignment: .left
    )
    
    private let hotelNameLabel = UILabel(
        text: "Steigenberger Makadi",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 22),
        alignment: .left
    )
    
    private let addressButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 14)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.attributedTitle = AttributedString(
            "Madinat Makadi, Safaga Road, Makadi Bay, Египет",
            attributes: attributes
        )
        
        let button = UIButton(configuration: buttonConfiguration)
        button.titleLabel?.textAlignment = .left
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let hotelPriceLabel = UILabel(
        text: "111",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 30),
        alignment: .left
    )
    
    private let forWayWithFlyLabel = UILabel(
        text: "За тур с перелетом",
        textColor: UIColor(named: "customGray"),
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 16),
        alignment: .left
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: Hotel) {
        rateLabel.text = String(data.rating) + " " + data.rating_name
        addressButton.titleLabel?.text = data.adress
        hotelPriceLabel.text = "От " + String(formatNumber(data.minimal_price)) + " ₽"
        forWayWithFlyLabel.text = data.price_for_it
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

// MARK: SetupUI with Constraints
private extension MainInformationView1 {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        self.addSubview(ratingView)
        ratingView.addSubview(starIcon)
        ratingView.addSubview(rateLabel)
        
        setupSubviews(
            hotelNameLabel, addressButton, hotelPriceLabel, forWayWithFlyLabel
        )
    }
    
    func setConstraints() {
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
            forWayWithFlyLabel.leftAnchor.constraint(equalTo: hotelPriceLabel.rightAnchor, constant: 8)
        ])
    }
}
