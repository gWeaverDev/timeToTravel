//
//  ListOfAirTravelVC.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

final class ListOfAirTravelVC: UIViewController {
    
    private let viewModel: ListOfAirTravelVM
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.registerCells(withModels: AirTravelCellVM.self)
        return table
    }()
    
    init(viewModel: ListOfAirTravelVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ListOfAirTravelVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.cellData(for: indexPath)
        let cell = tableView.dequeueReusableCell(withModel: model, for: indexPath)
        model.configureAny(cell)
        return cell
    }
    
}

