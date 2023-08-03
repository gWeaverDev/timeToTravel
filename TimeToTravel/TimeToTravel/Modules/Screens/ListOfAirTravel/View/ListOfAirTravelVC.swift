//
//  ListOfAirTravelVC.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

protocol ListOfAirTravelDelegate: AnyObject {
    func likeButtonTapped(for ticket: Ticket)
}

final class ListOfAirTravelVC: UIViewController {
    
    private let viewModel: ListOfAirTravelVM
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    private var navBarHeight: CGFloat = 0
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.registerCells(withModels: AirTravelCellVM.self)
        collection.delegate = self
        collection.dataSource = self
        return collection
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
        setupAppearance()
        setupLayout()
        binding()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.prefersLargeTitles = true
        collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.prefersLargeTitles = false
    }
    
    private func setupAppearance() {
        guard let navBar = navigationController?.navigationBar else { return }
        title = "Авиабилеты"
        view.backgroundColor = .purple
        navBarHeight = navBar.frame.size.height + 80
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(activityIndicator, collectionView)
        
        activityIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top).offset(navBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
    
    private func binding() {
        viewModel.stateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.activityIndicator.startAnimating()
            case .loaded:
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failLoad(let errorString):
                self.activityIndicator.stopAnimating()
                AlertManager.shared.presentAlert(for: self, errorString)
            case .reloadCollection(let indexPath):
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            return self.createSections()
        }
    }
    
    private func createSections() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

extension ListOfAirTravelVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel.cellData(for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath) as? AirTravelCell else {
            return UICollectionViewCell()
        }
        model.configureAny(cell)
        cell.delegate = self
        return cell
    }
}

extension ListOfAirTravelVC: ListOfAirTravelDelegate {
    
    func likeButtonTapped(for ticket: Ticket) {
        viewModel.likeTappedInCell(ticket: ticket)
    }
}

