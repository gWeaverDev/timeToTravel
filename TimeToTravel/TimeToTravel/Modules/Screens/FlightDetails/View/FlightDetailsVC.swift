//
//  FlightDetailsVC.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

final class FlightDetailsVC: UIViewController {
    
    private let viewModel: FlightDetailVM
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.registerCells(withModels: FlightDetailsCellVM.self)
        return collection
    }()
    
    init(viewModel: FlightDetailVM) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .purple
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(activityIndicator, collectionView)
        
        activityIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).offset(25)
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            return self.createSections()
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
    
}

extension FlightDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = viewModel.cellData(for: indexPath)
        let cell = collectionView.dequeueReusableCell(withModel: model, for: indexPath)
        model.configureAny(cell)
        return cell
    }
}
