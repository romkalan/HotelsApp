//
//  RoomsViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

final class RoomsViewController: UIViewController {
    
    let urlAPI = URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195")

    private var rooms: [Room] = []
    let networkManager = NetworkManager.shared
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 15
        table.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        setupUI()
        fetchRooms()
    }
    
    private func fetchRooms() {
        networkManager.fetchData(Rooms.self, from: urlAPI) { [weak self] result in
            switch result {
            case .success(let rooms):
                self?.rooms = rooms.rooms
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func reservationButton() {
        let vc = ReservationViewController()
        if !(self.navigationController!.topViewController! is ReservationViewController) {
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension RoomsViewController {
    private func initialSettings() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Steigenberger Makadi"
        let newBackButton = UIBarButtonItem.init(
            title: "",
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension RoomsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: RoomTableViewCell.reuseID,
            for: indexPath
        ) as? RoomTableViewCell else { return UITableViewCell() }
        
        let action = UIAction { [unowned self] _ in reservationButton() }
        cell.detailRoomButton.addAction(action, for: .touchUpInside)
        let room = rooms[indexPath.row]
        cell.configure(with: room)

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        537
    }
    
}
