//
//  PersonalInformationView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import UIKit

final class PersonalInformationView: UIView {
    
    private let maxNumberCount = 11
    private let regex = try! NSRegularExpression(
        pattern: "[\\+\\s-\\(\\)]",
        options: .caseInsensitive
    )
    private let typeOfNumberLabel = UILabel(
        text: "Информация о покупателе",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 22),
        alignment: .left
    )
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "+7 (***) ***-**-**"
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.backgroundColor = UIColor(named: "placeholderColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "email@address.com"
        textField.keyboardType = .emailAddress
        textField.backgroundColor = UIColor(named: "placeholderColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let message = UILabel(
        text: "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту",
        textColor: UIColor(named: "grayText"),
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 14),
        alignment: .left
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Mask for phoneNumber
    private func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for symbol in mask where index < numbers.endIndex {
            if symbol == "*" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(symbol)
            }
        }
        return result
    }
}

//MARK: - UITextFieldDelegate
extension PersonalInformationView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "+* (***) ***-**-**", phone: newString)
            return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = self.resignFirstResponder()
        return true
    }
}

//MARK: - SetupUI with Constraints
private extension PersonalInformationView {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        setupSubviews(typeOfNumberLabel, phoneNumberTextField, emailTextField, message)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            typeOfNumberLabel.topAnchor.constraint(equalTo: self.topAnchor),
            typeOfNumberLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            typeOfNumberLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: typeOfNumberLabel.bottomAnchor, constant: 32),
            phoneNumberTextField.leftAnchor.constraint(equalTo: self.leftAnchor),
            phoneNumberTextField.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16),
            emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor),
            emailTextField.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            message.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            message.leftAnchor.constraint(equalTo: self.leftAnchor),
            message.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}

