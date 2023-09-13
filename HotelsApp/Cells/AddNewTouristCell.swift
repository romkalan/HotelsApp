//
//  AddNewTouristCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 13.09.2023.
//

import UIKit

protocol AddTouristCellDelegate: AnyObject {
    func addTourist()
}

final class AddNewTouristCell: UITableViewCell {
    
    static let reuseID = "addNewTourist"

    weak var delegate: AddTouristCellDelegate?

    private let titleLabel = UILabel()
    private let addButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: AddNewTouristCell.reuseID)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {

        titleLabel.text = "Добавить туриста"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16)
        ])


        contentView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 32),
            addButton.widthAnchor.constraint(equalToConstant: 32)
        ])

        setupButton()
    }

    private func setupButton() {
        let icon = UIImage(named: "plus_icon")
        addButton.setImage(icon, for: .normal)
        addButton.backgroundColor = UIColor(red: 0.05, green: 0.45, blue: 1, alpha: 1)
        addButton.layer.cornerRadius = 6
        addButton.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }

    @objc private func touchButton() {
        delegate?.addTourist()
    }

}
