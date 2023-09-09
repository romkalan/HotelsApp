//
//  ReservationViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

class ReservationViewController: UIViewController {
    
    private let urlAPI = "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"
    private let networkManager = NetworkManager.shared
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let mainInformationView = MainInformationView2()
    private let reservationDataView = ReservationDataView()
    private let personalInformationView = PersonalInformationView()
    
    private lazy var payRoomButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont(name: "SF Pro Display", size: 16)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Оплатить 198 036 ₽", attributes: attributes)
        
        let button = UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction
            { [unowned self] _ in PayButton() }
        )
        button.titleLabel?.textAlignment = .center
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(contentView)
        contentView.addSubview(mainInformationView)
        contentView.addSubview(reservationDataView)
        contentView.addSubview(personalInformationView)
        contentView.addSubview(payRoomButton)
        
        fetchReservationInfo()
        initialSettings()
        setupUI()
    }
    
    private func initialSettings() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Бронирование"
        let newBackButton = UIBarButtonItem.init(
            title: "",
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }
    
    private func PayButton() {
        let vc = FinalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Networking
    private func fetchReservationInfo() {
        networkManager.fetchData(Reservation.self, from: URL(string: urlAPI)) { [weak self] result in
            switch result {
            case .success(let reservationInfo):
                self?.mainInformationView.configure(data: reservationInfo)
                self?.reservationDataView.configure(data: reservationInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
}



//MARK: - SetupUI Elements
extension ReservationViewController {
    private func setupUI() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupMainInformationViewConstraints()
        setupReservationDataViewConstraints()
        setupPersonalInformationViewConstraints()
        setupPayRoomButtonConstraints()
    }
    
    private func setupScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height)
        ])
    }
    
    private func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.size.height + 80)
        ])
    }
    
    private func setupMainInformationViewConstraints() {
        mainInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainInformationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainInformationView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupReservationDataViewConstraints() {
        reservationDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reservationDataView.topAnchor.constraint(equalTo: mainInformationView.bottomAnchor),
            reservationDataView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            reservationDataView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            reservationDataView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func setupPersonalInformationViewConstraints() {
        personalInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personalInformationView.topAnchor.constraint(equalTo: reservationDataView.bottomAnchor, constant: 16),
            personalInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            personalInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            personalInformationView.heightAnchor.constraint(equalToConstant: 232)
        ])
    }
    
    private func setupPayRoomButtonConstraints() {
        payRoomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payRoomButton.topAnchor.constraint(equalTo: personalInformationView.bottomAnchor, constant: 16),
            payRoomButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            payRoomButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            payRoomButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}
