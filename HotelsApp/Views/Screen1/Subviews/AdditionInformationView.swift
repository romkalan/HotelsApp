//
//  AdditionInformationView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

final class AdditionInformationView: UIView {

    private let aboutHotelLabel = UILabel(
        text: "Об отеле",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 22),
        alignment: .left
    )
    
    private lazy var advantage1: UILabel = {
        setupUIWith(text: "3-я линия")
    }()
    
    private lazy var advantage2: UILabel = {
        setupUIWith(text: "Платный Wi-Fi в фойе")
    }()
    
    private lazy var advantage3: UILabel = {
        setupUIWith(text: "30 км от аэропорта")
    }()
    
    private lazy var advantage4: UILabel = {
        setupUIWith(text: "1 км до пляжа")
    }()
    
    private let aboutHotelInfoLabel = UILabel(
        text: "",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 16),
        alignment: .left
    )
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 15
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIWith(text: String) -> UILabel {
        let label = UILabel(
            text: text,
            textColor: UIColor(named: "grayText"),
            backgroundColor: UIColor(named: "backgroundGray") ?? .black,
            font: UIFont(name: "SF Pro Display", size: 16),
            alignment: .left
        )
        return label
    }
    
    func configure(with data: Hotel) {
        aboutHotelInfoLabel.text = data.about_the_hotel.description
        advantage1.text = data.about_the_hotel.peculiarities[0]
        advantage2.text = data.about_the_hotel.peculiarities[1]
        advantage3.text = data.about_the_hotel.peculiarities[2]
        advantage4.text = data.about_the_hotel.peculiarities[3]
    }
}
//MARK: - SetupUI with Constraints
private extension AdditionInformationView {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        setupSubviews(
            aboutHotelLabel, advantage1, advantage2, advantage3,
            advantage4, aboutHotelInfoLabel, tableView
        )
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            aboutHotelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            aboutHotelLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            aboutHotelLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            aboutHotelLabel.heightAnchor.constraint(equalToConstant: 30),
            
            advantage1.topAnchor.constraint(equalTo: aboutHotelLabel.bottomAnchor, constant: 24),
            advantage1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            advantage1.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            advantage1.heightAnchor.constraint(equalToConstant: 40),
            
            advantage2.topAnchor.constraint(equalTo: aboutHotelLabel.bottomAnchor, constant: 24),
            advantage2.leftAnchor.constraint(equalTo: advantage1.rightAnchor, constant: 24),
            advantage2.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            advantage2.heightAnchor.constraint(equalToConstant: 40),
            
            advantage3.topAnchor.constraint(equalTo: advantage1.bottomAnchor, constant: 8),
            advantage3.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            advantage3.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            advantage3.heightAnchor.constraint(equalToConstant: 40),
            
            advantage4.topAnchor.constraint(equalTo: advantage2.bottomAnchor, constant: 8),
            advantage4.leftAnchor.constraint(equalTo: advantage3.rightAnchor, constant: 24),
            advantage4.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            advantage4.heightAnchor.constraint(equalToConstant: 40),
            
            aboutHotelInfoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 166),
            aboutHotelInfoLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            aboutHotelInfoLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: aboutHotelInfoLabel.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 343),
            tableView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}

extension AdditionInformationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: TableViewCell.reuseID,
            for: indexPath
        ) as? TableViewCell else { return UITableViewCell() }
                
        switch indexPath.row {
        case 0:
            cell.configure(with: UIImage(named: "emoji-happy")!, and: "Удобства", and: "Самое необходимое")
        case 1:
            cell.configure(with: UIImage(named: "tick-square")!, and: "Что включено", and: "Самое необходимое")
        case 2:
            cell.configure(with: UIImage(named: "close-square")!, and: "Что не включено", and: "Самое необходимое")
        default:
            break
        }
        cell.backgroundColor = UIColor(named: "backgroundGray")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
