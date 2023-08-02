//
//  FlightDetailsVC.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import UIKit
import SnapKit

final class FlightDetailsVC: UIViewController {
    
    private let viewModel: FlightDetailVM
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = .orange
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.registerCells(withModels: FlightDetailsCellVM.self)
        collection.delegate = self
        collection.dataSource = self
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
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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

extension FlightDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
}
