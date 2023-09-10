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
    
    //MARK: - format for PhoneNumber
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, range: range, withTemplate: "")
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(
                of: pattern,
                with: "$1 ($2) $3",
                options: .regularExpression,
                range: regRange
            )
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(
                of: pattern,
                with: "$1 ($2) $3-$4-$5",
                options: .regularExpression,
                range: regRange
            )
        }
        return "+" + number
    }
}

//MARK: - UITextFieldDelegate
extension PersonalInformationView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = format(
            phoneNumber: fullString,
            shouldRemoveLastDigit: range.length == 1
        )
        return false
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

