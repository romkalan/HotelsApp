//
//  MainInformationView2.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import UIKit

final class MainInformationView2: UIView {
    
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
        text: "",
        textColor: UIColor(named: "customYellow"),
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 16),
        alignment: .left
    )
    
    private let hotelNameLabel = UILabel(
        text: "Steigenberg Makadi",
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Reservation) {
        rateLabel.text = String(data.horating) + " " + data.rating_name
        addressButton.titleLabel?.text = data.hotel_adress
    }
}

// MARK: SetupUI with Constraints
private extension MainInformationView2 {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        setupSubviews(ratingView, hotelNameLabel, addressButton)
        ratingView.addSubview(starIcon)
        ratingView.addSubview(rateLabel)
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
        ])
    }
}

