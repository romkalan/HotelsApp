//
//  FinalViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 08.09.2023.
//

import UIKit

final class FinalViewController: UIViewController {
    
    private lazy var finalMessage: UILabel = {
        let label = UILabel()
        label.text = "Ваш заказ принят в работу"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "congratulations")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var additionMessage: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
        label.textAlignment = .center
        label.textColor = UIColor(named: "grayText")
        label.font = UIFont(name: "SF Pro Display", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var okButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont(name: "SF Pro Display", size: 16)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Супер", attributes: attributes)
        
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction
            { [unowned self] _ in closeScreens() }
        )
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func closeScreens() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        setupUI()
    }
    
    private func initialSettings() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Заказ оплачен"
        let newBackButton = UIBarButtonItem.init(
            title: "",
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }
}

private extension FinalViewController {
    func setupUI() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(finalMessage)
        view.addSubview(image)
        view.addSubview(additionMessage)
        view.addSubview(okButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            finalMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finalMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: finalMessage.topAnchor, constant: -24),
            
            additionMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            additionMessage.widthAnchor.constraint(equalToConstant: 329),
            additionMessage.topAnchor.constraint(equalTo: finalMessage.bottomAnchor, constant: 24),
            
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            okButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
