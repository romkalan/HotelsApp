//
//  ReservationViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

class ReservationViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let mainInformationView = MainInformationView2()
    private let reservationDataView = ReservationDataView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(contentView)
        contentView.addSubview(mainInformationView)
        contentView.addSubview(reservationDataView)
        
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

}

//MARK: - SetupUI Elements
extension ReservationViewController {
    private func setupUI() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupMainInformationViewConstraints()
        setupReservationDataViewConstraints()
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
    
}
