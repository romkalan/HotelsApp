//
//  RoomsViewController.swift
//  HotelsApp
//
//  Created by Roman Lantsov on 07.09.2023.
//

import UIKit

class RoomsViewController: UIViewController {
    
    let urlAPI = URL(string: "https://run.mocky.io/v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd")
    private var rooms = Rooms(rooms: [])
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
    }
    
    private func fetchRooms() {
        networkManager.fetchData(Rooms.self, from: urlAPI) { [weak self] result in
            switch result {
            case .success(let rooms):
                let room = rooms.rooms[0]
                self?.tableView.reloadData()
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

extension RoomsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (
            withIdentifier: RoomTableViewCell.reuseID,
            for: indexPath
        ) as? RoomTableViewCell else { return UITableViewCell() }
        
        let action = UIAction { [unowned self] _ in reservationButton() }
        cell.detailRoomButton.addAction(action, for: .touchUpInside)
//        let room = rooms.rooms[indexPath.row]
//        cell.configure(with: room)

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        537
    }
    
}
