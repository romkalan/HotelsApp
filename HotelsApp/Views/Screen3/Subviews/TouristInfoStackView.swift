//
//  TouristInfoStackView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 11.09.2023.
//

import UIKit

final class TouristInfoStackView: UIView {
    
    private var isHide = false {
        didSet {
            let icon = UIImage(named: isHide ? "chevron.up" : "chevron.down")
            headerForStackView.showInfoButton.setImage(icon, for: .normal)
        }
    }
    
    private let stackView = UIStackView()
    let headerForStackView = HeaderForTableView()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addAction(for: headerForStackView.showInfoButton)
        setupButton()
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
    
    private func hide(textFields: UIView...) {
        textFields.forEach { textField in
            UIView.animate(withDuration: 0.3) {
                textField.isHidden.toggle()
                self.layoutIfNeeded()
            }
        }
    }
    
    private func addAction(for button: UIButton) {
        let action = UIAction { [unowned self] _ in
            hide(textFields: nameTextField, surNameTextField, birthВateTextField,
                 nationalityTextField, passportTextField, validityOfPassportTextField)
        }
        button.addAction(action, for: .touchUpInside)
        isHide.toggle()
    }
    
    private func setupButton() {
        let icon = UIImage(named: isHide ? "chevron.up" : "chevron.down")
        headerForStackView.showInfoButton.setImage(icon, for: .normal)
        headerForStackView.showInfoButton.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }
    
    @objc private func touchButton() {
        nameTextField.isHidden = isHide ? true : false
        surNameTextField.isHidden = isHide ? true : false
        birthВateTextField.isHidden = isHide ? true : false
        nationalityTextField.isHidden = isHide ? true : false
        passportTextField.isHidden = isHide ? true : false
        validityOfPassportTextField.isHidden = isHide ? true : false
        isHide.toggle()
    }
}

//MARK: - SetupUI with Constraints
private extension TouristInfoStackView {
    func setupUI() {
        configureStackView()
        addViews()
        setConstraints()
    }
    
    func configureStackView() {
        self.addSubview(stackView)
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
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
