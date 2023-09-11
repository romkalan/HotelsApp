//
//  ReservationViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

final class ReservationViewController: UIViewController {
    
    private let urlAPI = "https://run.mocky.io/v3/e8868481-743f-4eb2-a0d7-2bc4012275c8"
    private let networkManager = NetworkManager.shared
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let mainInformationView = MainInformationView2()
    private let reservationDataView = ReservationDataView()
    private let personalInformationView = PersonalInformationView()
    private let touristInfoView = TouristInfoView()
    private let resumePriceInfoView = ResumePriceInfoView()
    
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
        fetchReservationInfo()
        initialSettings()
        setupUI()
    }
    
    private func PayButton() {
        let vc = FinalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    // MARK: - Networking
    private func fetchReservationInfo() {
        networkManager.fetchData(Reservation.self, from: URL(string: urlAPI)) { [weak self] result in
            switch result {
            case .success(let reservationInfo):
                DispatchQueue.main.async {
                    self?.mainInformationView.configure(data: reservationInfo)
                    self?.reservationDataView.configure(data: reservationInfo)
                    self?.resumePriceInfoView.configure(data: reservationInfo)
                    self?.payRoomButton.titleLabel?.text = "Оплатить " + String(reservationInfo.tour_price + reservationInfo.service_charge + reservationInfo.service_charge) + " ₽"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - SetupUI with Constraints
private extension ReservationViewController {
    func setupUI() {
        addViews()
        scrollView.backgroundColor = .systemBackground
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainInformationView)
        contentView.addSubview(reservationDataView)
        contentView.addSubview(personalInformationView)
        contentView.addSubview(touristInfoView)
        contentView.addSubview(resumePriceInfoView)
        contentView.addSubview(payRoomButton)
        
    }
    
    func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        mainInformationView.translatesAutoresizingMaskIntoConstraints = false
        reservationDataView.translatesAutoresizingMaskIntoConstraints = false
        personalInformationView.translatesAutoresizingMaskIntoConstraints = false
        payRoomButton.translatesAutoresizingMaskIntoConstraints = false
        touristInfoView.translatesAutoresizingMaskIntoConstraints = false
        resumePriceInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainInformationView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            mainInformationView.heightAnchor.constraint(equalToConstant: 120),
            
            reservationDataView.topAnchor.constraint(equalTo: mainInformationView.bottomAnchor),
            reservationDataView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            reservationDataView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            reservationDataView.heightAnchor.constraint(equalToConstant: 280),
            
            personalInformationView.topAnchor.constraint(equalTo: reservationDataView.bottomAnchor),
            personalInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            personalInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            personalInformationView.heightAnchor.constraint(equalToConstant: 190),
            
            touristInfoView.topAnchor.constraint(equalTo: personalInformationView.bottomAnchor),
            touristInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            touristInfoView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            touristInfoView.heightAnchor.constraint(equalToConstant: CGFloat(touristInfoView.cellCount * 63)),
            
            resumePriceInfoView.topAnchor.constraint(equalTo: touristInfoView.bottomAnchor),
            resumePriceInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            resumePriceInfoView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            resumePriceInfoView.heightAnchor.constraint(equalToConstant: 156),
            
            payRoomButton.topAnchor.constraint(equalTo: resumePriceInfoView.bottomAnchor),
            payRoomButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            payRoomButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            payRoomButton.heightAnchor.constraint(equalToConstant: 48),
            payRoomButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
