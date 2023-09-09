//
//  ReservationDataView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import UIKit

final class ReservationDataView: UIView {

    private lazy var flyPositionInfo1: UILabel = {
        setup("Вылет из", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyPositionInfo2: UILabel = {
        setup("Страна, город", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyPositionInfo3: UILabel = {
        setup("Даты", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyPositionInfo4: UILabel = {
        setup("Кол-во ночей", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyPositionInfo5: UILabel = {
        setup("Отель", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyPositionInfo6: UILabel = {
        setup("Номер", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyPositionInfo7: UILabel = {
        setup("Питание", and: UIColor(named: "customGray") ?? .black)
    }()
    private lazy var flyInfo1: UILabel = {
        setup("Сантк-Петербург", and: .black)
    }()
    private lazy var flyInfo2: UILabel = {
        setup("Египет, Хургада", and: .black)
    }()
    private lazy var flyInfo3: UILabel = {
        setup("19.09.2023 - 27.09.2023", and: .black)
    }()
    private lazy var flyInfo4: UILabel = {
        setup("7 ночей", and: .black)
    }()
    private lazy var flyInfo5: UILabel = {
        setup("Steigenberger Makadi", and: .black)
    }()
    private lazy var flyInfo6: UILabel = {
        setup("Стандартный с видом на бассейн или сад", and: .black)
    }()
    private lazy var flyInfo7: UILabel = {
        setup("Все включено", and: .black)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ text: String, and color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = color
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func configure(data: Reservation) {
        flyInfo1.text = data.departure
        flyInfo2.text = data.arrival_country
        flyInfo3.text = data.tour_date_start + " - " + data.tour_date_stop
        flyInfo4.text = String(data.number_of_nights) + " ночей"
        flyInfo6.text = data.room
        flyInfo7.text = data.nutrition
    }
}

extension ReservationDataView {
        private func setupUI() {
        setupSubviews(flyPositionInfo1, flyInfo1, flyPositionInfo2, flyInfo2, flyPositionInfo3,
                      flyInfo3, flyPositionInfo4, flyInfo4, flyPositionInfo5, flyInfo5,
                      flyPositionInfo6, flyInfo6, flyPositionInfo7, flyInfo7
        )
       
        NSLayoutConstraint.activate([
            flyPositionInfo1.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            flyPositionInfo1.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo1.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo1.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            flyInfo1.leftAnchor.constraint(equalTo: flyPositionInfo1.rightAnchor, constant: 16),
            flyInfo1.widthAnchor.constraint(equalToConstant: 205),
            
            flyPositionInfo2.topAnchor.constraint(equalTo: flyPositionInfo1.bottomAnchor, constant: 16),
            flyPositionInfo2.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo2.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo2.topAnchor.constraint(equalTo: flyInfo1.bottomAnchor, constant: 16),
            flyInfo2.leftAnchor.constraint(equalTo: flyPositionInfo2.rightAnchor, constant: 16),
            flyInfo2.widthAnchor.constraint(equalToConstant: 205),
            
            flyPositionInfo3.topAnchor.constraint(equalTo: flyPositionInfo2.bottomAnchor, constant: 16),
            flyPositionInfo3.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo3.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo3.topAnchor.constraint(equalTo: flyInfo2.bottomAnchor, constant: 16),
            flyInfo3.leftAnchor.constraint(equalTo: flyPositionInfo3.rightAnchor, constant: 16),
            flyInfo3.widthAnchor.constraint(equalToConstant: 205),
            
            flyPositionInfo4.topAnchor.constraint(equalTo: flyPositionInfo3.bottomAnchor, constant: 16),
            flyPositionInfo4.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo4.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo4.topAnchor.constraint(equalTo: flyInfo3.bottomAnchor, constant: 16),
            flyInfo4.leftAnchor.constraint(equalTo: flyPositionInfo4.rightAnchor, constant: 16),
            flyInfo4.widthAnchor.constraint(equalToConstant: 205),
            
            flyPositionInfo5.topAnchor.constraint(equalTo: flyPositionInfo4.bottomAnchor, constant: 16),
            flyPositionInfo5.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo5.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo5.topAnchor.constraint(equalTo: flyInfo4.bottomAnchor, constant: 16),
            flyInfo5.leftAnchor.constraint(equalTo: flyPositionInfo5.rightAnchor, constant: 16),
            flyInfo5.widthAnchor.constraint(equalToConstant: 205),
            
            flyPositionInfo6.topAnchor.constraint(equalTo: flyPositionInfo5.bottomAnchor, constant: 16),
            flyPositionInfo6.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo6.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo6.topAnchor.constraint(equalTo: flyInfo5.bottomAnchor, constant: 16),
            flyInfo6.leftAnchor.constraint(equalTo: flyPositionInfo6.rightAnchor, constant: 16),
            flyInfo6.widthAnchor.constraint(equalToConstant: 205),
            
            flyPositionInfo7.topAnchor.constraint(equalTo: flyPositionInfo6.bottomAnchor, constant: 34),
            flyPositionInfo7.leftAnchor.constraint(equalTo: self.leftAnchor),
            flyPositionInfo7.widthAnchor.constraint(equalToConstant: 110),
            
            flyInfo7.topAnchor.constraint(equalTo: flyInfo6.bottomAnchor, constant: 16),
            flyInfo7.leftAnchor.constraint(equalTo: flyPositionInfo7.rightAnchor, constant: 16),
            flyInfo7.widthAnchor.constraint(equalToConstant: 205),
            
        ])
    }
}
