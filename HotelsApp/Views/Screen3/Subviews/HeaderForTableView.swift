//
//  HeaderForTableView.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 09.09.2023.
//

import UIKit

final class HeaderForTableView: UIView {
    
    private lazy var showInfoButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont(name: "SF Pro Display", size: 16)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.image = UIImage(systemName: "chevron.up")
        buttonConfiguration.attributedTitle = AttributedString("", attributes: attributes)
        buttonConfiguration.baseBackgroundColor = UIColor(named: "blueButtonColor")
        buttonConfiguration.baseForegroundColor = .systemBlue
        
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction
            { [unowned self] _ in showInfo() }
        )
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    private let label = UILabel(
        text: "Первый турист",
        textColor: .black,
        backgroundColor: .clear,
        font: UIFont(name: "SF Pro Display", size: 22),
        alignment: .left
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showInfo() {
        
    }
    
}

//MARK: - SetupUI with Constraints
private extension HeaderForTableView {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        self.addSubview(label)
        self.addSubview(showInfoButton)
    }
    
    func setConstraints() {
        showInfoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            showInfoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            showInfoButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            showInfoButton.widthAnchor.constraint(equalToConstant: 32),
            showInfoButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
