//
//  FlightDetailsVC.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

protocol FlightDetailsDelegate: AnyObject {
    func ticketIsLikedOnDetail(for ticket: Ticket)
}

final class FlightDetailsVC: UIViewController {
    
    //MARK: - Private properties
    private let viewModel: FlightDetailVM
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.registerCells(withModels: FlightDetailsCellVM.self)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    //MARK: - Lifecycle
    init(viewModel: FlightDetailVM) {
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
        collectionView.reloadData()
    }
    
    //MARK: - Private methods
    private func setupAppearance() {
        view.backgroundColor = .purple
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
    
    private func binding() {
        viewModel.stateChange = { [unowned self] state in
            switch state {
            case .reloadCollection:
                self.collectionView.reloadData()
            }
        }
    }
    
    private func createSections() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, enviroment in
            return self?.createSections()
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FlightDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = viewModel.cellData(for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath) as? FlightDetailCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        model.configureAny(cell)
        return cell
    }
}

//MARK: - FlightDetailsDelegate
extension FlightDetailsVC: FlightDetailsDelegate {
    
    func ticketIsLikedOnDetail(for ticket: Ticket) {
        viewModel.likeTappedInCell(for: ticket)
    }
}
