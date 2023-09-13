//
//  TouristInfoCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 13.09.2023.
//

import UIKit

import UIKit

protocol TouristInfoCellDelegate: AnyObject {
    func updateCellHeight(isOpen: Bool)
}

final class TouristInfoCell: UITableViewCell {
    
    static let reuseID = "tourist"

    weak var delegate: TouristInfoCellDelegate?

    private var isOpen = true {
        didSet {
            let icon = UIImage(named: isOpen ? "arrow_top" : "arrow_down")
            button.setImage(icon, for: .normal)
        }
    }

    private let titleLabel = UILabel()
    private let button = UIButton()
    private let stackView = UIStackView()

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
        super.init(style: .default, reuseIdentifier: TouristInfoCell.reuseID)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

//    func isValid() -> Bool {
//        let isNameValid = nameField.isValid()
//        let isSurnameValid = surnameField.isValid()
//        let isBirthValid = birthDateField.isValid()
//        let isCitizenValid = citizenField.isValid()
//        let isPassportValid = passportNumberField.isValid()
//        let isExpiredValid = passportExpiredField.isValid()
//
//        return isNameValid &&
//        isSurnameValid &&
//        isBirthValid &&
//        isCitizenValid &&
//        isPassportValid &&
//        isExpiredValid
//    }

    public func touristNumber(title: String) {
        titleLabel.text = title
    }

    private func setupCell() {

        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 32),
            button.widthAnchor.constraint(equalToConstant: 32)
        ])

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.contentMode = .scaleToFill

        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(20, after: titleLabel)

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameTextField)

        surNameTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(surNameTextField)

        birthВateTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(birthВateTextField)

        nationalityTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nationalityTextField)

        passportTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(passportTextField)

        validityOfPassportTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(validityOfPassportTextField)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            nameTextField.heightAnchor.constraint(equalToConstant: 52),
            surNameTextField.heightAnchor.constraint(equalToConstant: 52),
            birthВateTextField.heightAnchor.constraint(equalToConstant: 52),
            nationalityTextField.heightAnchor.constraint(equalToConstant: 52),
            passportTextField.heightAnchor.constraint(equalToConstant: 52),
            validityOfPassportTextField.heightAnchor.constraint(equalToConstant: 52),
        ])

        setupButton()
    }

    private func setupButton() {
        let icon = UIImage(named: isOpen ? "arrow_top" : "arrow_down")
        button.setImage(icon, for: .normal)
        button.backgroundColor = UIColor(red: 0.05, green: 0.45, blue: 1, alpha: 0.1)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }

    @objc private func touchButton() {
        nameTextField.isHidden = isOpen ? true : false
        surNameTextField.isHidden = isOpen ? true : false
        birthВateTextField.isHidden = isOpen ? true : false
        nationalityTextField.isHidden = isOpen ? true : false
        passportTextField.isHidden = isOpen ? true : false
        validityOfPassportTextField.isHidden = isOpen ? true : false
        isOpen.toggle()
        delegate?.updateCellHeight(isOpen: isOpen)
    }
}

