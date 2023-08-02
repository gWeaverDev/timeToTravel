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
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.registerCells(withModels: AirTravelCellVM.self, EmptyCellVM.self)
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
        binding()
        viewModel.getData()
    }
    
    private func setupUI() {
        view.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func binding() {
        viewModel.stateChanger = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.activityIndicator.startAnimating()
            case .loaded:
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failLoad(let errorString):
                self.activityIndicator.stopAnimating()
                AlertNotifications.shared.presentAlert(for: self, errorString)
            }
        }
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(activityIndicator, tableView)
        
        activityIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).offset(25)
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

final class AlertNotifications {
    
   static let shared = AlertNotifications()
    
   private init () {}
    
    func presentAlert(for viewController: UIViewController, _ text: String) {
        
        let alertController = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
    
}

