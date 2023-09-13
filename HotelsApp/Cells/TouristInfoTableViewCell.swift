//
//  TouristInfoCellTableViewCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 12.09.2023.
//

import UIKit

final class TouristInfoTableViewCell: UITableViewCell {
    
    static let reuseID = "tourist"
    
    private var isHide = false {
        didSet {
            let icon = UIImage(named: isHide ? "chevron.up" : "chevron.down")
            headerForStackView.showInfoButton.setImage(icon, for: .normal)
        }
    }
    
    private let stackView = UIStackView()
    let headerForStackView = HeaderForTableView()
//    private let numberOfTouristLabel = UILabel()
//    private let button = UIButton()
    
    lazy var nameTextField: UITextField = {
        createTextField(withText: "Иван", andPlaceholder: "Имя")
    }()
    
    lazy var surNameTextField: UITextField = {
        createTextField(withText: "Иванов", andPlaceholder: "Фамилия")
    }()
    
    lazy var birthВateTextField: UITextField = {
        createTextField(withText: "", andPlaceholder: "Дата рождения")
    }()
    
    lazy var nationalityTextField: UITextField = {
        createTextField(withText: "", andPlaceholder: "Гражданство")
    }()
    
    lazy var passportTextField: UITextField = {
        createTextField(withText: "", andPlaceholder: "Номер загранпаспорта")
    }()
    
    lazy var validityOfPassportTextField: UITextField = {
        createTextField(withText: "", andPlaceholder: "Срок действия загранпаспорта")
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
    
    private func createTextField(withText text: String, andPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = text
        textField.placeholder = placeholder
        textField.keyboardType = .default
        textField.isHidden = false
        textField.backgroundColor = UIColor(named: "placeholderColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

}

// MARK: - NSLayoutConstraint
private extension TouristInfoTableViewCell {
    func setupUI() {
        configureStackView()
        addViews()
        setConstraints()
    }
    
    func configureStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
    }
    
    func addViews() {
        stackView.addArrangedSubview(headerForStackView)
        add(
            textFields: nameTextField, surNameTextField, birthВateTextField,
            nationalityTextField, passportTextField, validityOfPassportTextField
        )
    }
    
    func add(textFields: UITextField...) {
        textFields.forEach { textField in
            stackView.addArrangedSubview(textField)
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 52),
            surNameTextField.heightAnchor.constraint(equalToConstant: 52),
            birthВateTextField.heightAnchor.constraint(equalToConstant: 52),
            nationalityTextField.heightAnchor.constraint(equalToConstant: 52),
            passportTextField.heightAnchor.constraint(equalToConstant: 52),
            validityOfPassportTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
