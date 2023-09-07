//
//  AdditionInformationView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

class AdditionInformationView: UIView {

    private lazy var aboutHotelLabel: UILabel = {
        let label = UILabel()
        label.text = "Об отеле"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private lazy var aboutHotelInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 15
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
//    private lazy var chooseRoomButton: UIButton = {
//        var attributes = AttributeContainer()
//        attributes.font = UIFont.boldSystemFont(ofSize: 16)
//
//        var buttonConfiguration = UIButton.Configuration.filled()
//        buttonConfiguration.attributedTitle = AttributedString("К выбору номера", attributes: attributes)
//
//        let button = UIButton(configuration: buttonConfiguration)
//        button.titleLabel?.textAlignment = .center
////        button.backgroundColor = UIColor(red: 13, green: 114, blue: 255, alpha: 1)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIWith(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.textColor = UIColor(named: "grayText")
        label.backgroundColor = UIColor(named: "backgroundGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}

extension AdditionInformationView {
    private func setupUI() {
        self.addSubview(aboutHotelLabel)
        self.addSubview(advantage1)
        self.addSubview(advantage2)
        self.addSubview(advantage3)
        self.addSubview(advantage4)
        self.addSubview(aboutHotelInfoLabel)
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            aboutHotelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            aboutHotelLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            aboutHotelLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            aboutHotelLabel.heightAnchor.constraint(equalToConstant: 30),
            
            advantage1.topAnchor.constraint(equalTo: aboutHotelLabel.bottomAnchor, constant: 24),
            advantage1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            
            advantage2.topAnchor.constraint(equalTo: aboutHotelLabel.bottomAnchor, constant: 24),
            advantage2.leftAnchor.constraint(equalTo: advantage1.rightAnchor, constant: 24),
            
            advantage3.topAnchor.constraint(equalTo: advantage1.bottomAnchor, constant: 8),
            advantage3.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            
            advantage4.topAnchor.constraint(equalTo: advantage2.bottomAnchor, constant: 8),
            advantage4.leftAnchor.constraint(equalTo: advantage3.rightAnchor, constant: 24),
            
            aboutHotelInfoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 136),
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
