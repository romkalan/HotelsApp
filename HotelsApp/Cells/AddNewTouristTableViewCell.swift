//
//  AddNewTouristCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 12.09.2023.
//

import UIKit

final class AddNewTouristTableViewCell: UITableViewCell {
    
    static let reuseID = "addNewTourist"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Добавить туриста"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus_icon"), for: .normal)
        button.backgroundColor = UIColor(named: "blueButtonColor")
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - SetupUI and Constraint
private extension AddNewTouristTableViewCell {
    func setupUI() {
        addViews()
        setupButton()
        setConstraints()
    }
    
    func addViews() {
        add(views: titleLabel, button)
    }
    
    func setupButton() {
//        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }
    
    func add(views: UIView...) {
        views.forEach { view in
            contentView.addSubview(view)
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 32),
            button.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
