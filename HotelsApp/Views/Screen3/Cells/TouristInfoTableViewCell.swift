//
//  TouristInfoTableViewCell.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 09.09.2023.
//

import UIKit

final class TouristInfoTableViewCell: UITableViewCell {
    static let reuseID = "info"
    
    private let infoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Имя"
        textField.keyboardType = .default
        textField.backgroundColor = UIColor(named: "placeholderColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(placeholder: String, text: String) {
        infoTextField.placeholder = placeholder
        infoTextField.text = text
    }

}

// MARK: - NSLayoutConstraint
private extension TouristInfoTableViewCell {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        self.addSubview(infoTextField)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            infoTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            infoTextField.leftAnchor.constraint(equalTo: self.leftAnchor),
            infoTextField.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
}

//extension TouristInfoTableViewCell {
//    textfieldshoud
//}
