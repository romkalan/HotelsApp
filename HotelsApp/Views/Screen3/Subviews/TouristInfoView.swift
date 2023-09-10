//
//  TouristInfoView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import UIKit

final class TouristInfoView: UIView {
    
    var cellCount = 6 {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 15
        table.register(
            TouristInfoTableViewCell.self,
            forCellReuseIdentifier: TouristInfoTableViewCell.reuseID
        )
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupUI with Constraints
private extension TouristInfoView {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        self.addSubview(tableView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TouristInfoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        HeaderForTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: TouristInfoTableViewCell.reuseID,
            for: indexPath
        ) as? TouristInfoTableViewCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.config(placeholder: "Имя", text: "Иван")
        case 1:
            cell.config(placeholder: "Фамилия", text: "Иванов")
        case 2:
            cell.config(placeholder: "Дата рождения", text: "")
        case 3:
            cell.config(placeholder: "Гражданство", text: "")
        case 4:
            cell.config(placeholder: "Номер загранпаспорта", text: "")
        case 5:
            cell.config(placeholder: "Срок действия загранпаспорта", text: "")
        default:
            break
        }
      
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
}
