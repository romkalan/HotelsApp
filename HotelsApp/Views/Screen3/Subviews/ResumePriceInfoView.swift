//
//  ResumePriceInfoView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 10.09.2023.
//

import UIKit

final class ResumePriceInfoView: UIView {
    
    private lazy var tourLabel: UILabel = {
        setup("Тур", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var priceForTourLabel: UILabel = {
        setup("123132", and: .black)
    }()
    private lazy var fuelLabel: UILabel = {
        setup("Топливный сбор", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var priceForFuelLabel: UILabel = {
        setup("123132", and: .black)
    }()
    private lazy var serviceLabel: UILabel = {
        setup("Сервисный сбор", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var priceForServiceLabel: UILabel = {
        setup("123132", and: .black)
    }()
    private lazy var finalPayLabel: UILabel = {
        setup("К оплате", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var finalPriceLabel: UILabel = {
        setup("123132", and: .systemBlue)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ text: String, and color: UIColor) -> UILabel {
        let label = UILabel(
            text: text,
            textColor: color,
            backgroundColor: .clear,
            font: UIFont(name: "SF Pro Display", size: 16),
            alignment: .left
        )
        return label
    }
    
    func configure(data: Reservation) {
        priceForTourLabel.text = String(formatNumber(data.tour_price)) + " ₽"
        priceForFuelLabel.text = String(formatNumber(data.fuel_charge)) + " ₽"
        priceForServiceLabel.text = String(formatNumber(data.service_charge)) + " ₽"
        finalPriceLabel.text = String(formatNumber(data.tour_price + data.service_charge + data.service_charge)) + " ₽"
    }
    
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
}

//MARK: - SetupUI with Constraints
private extension ResumePriceInfoView {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        self.setupSubviews(
            tourLabel, priceForTourLabel, fuelLabel, priceForFuelLabel, serviceLabel,
            priceForServiceLabel, finalPayLabel, finalPriceLabel
        )
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            tourLabel.topAnchor.constraint(equalTo: self.topAnchor),
            tourLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            priceForTourLabel.centerYAnchor.constraint(equalTo: tourLabel.centerYAnchor),
            priceForTourLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            fuelLabel.topAnchor.constraint(equalTo: tourLabel.bottomAnchor, constant: 16),
            fuelLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            priceForFuelLabel.centerYAnchor.constraint(equalTo: fuelLabel.centerYAnchor),
            priceForFuelLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            serviceLabel.topAnchor.constraint(equalTo: fuelLabel.bottomAnchor, constant: 16),
            serviceLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            priceForServiceLabel.centerYAnchor.constraint(equalTo: serviceLabel.centerYAnchor),
            priceForServiceLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            finalPayLabel.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor, constant: 16),
            finalPayLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            finalPriceLabel.centerYAnchor.constraint(equalTo: finalPayLabel.centerYAnchor),
            finalPriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor),

        ])
    }
}
