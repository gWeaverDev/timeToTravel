//
//  AirTravelCell.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

final class AirTravelCell: UICollectionViewCell {

    struct Model {
        let startDate: String
        let startCity: String
        let endDate: String
        let endCity: String
        let price: String
    }
    
    var routing: (() -> Void)?
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .systemRed
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
        return button
    }()
    
    private let startDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let startCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let endDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let endCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let horizontalSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.7)
        return view
    }()
    
    private let verticalSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.7)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        cellAppearance()
        addTargets()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with model: Model) {
        self.startDate.text = model.startDate
        self.startCity.text = model.startCity
        self.endDate.text = model.endDate
        self.endCity.text = model.endCity
        self.priceLabel.text = model.price
    }
    
    private func cellAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    private func addTargets() {
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGR)
    }
    
    @objc
    private func likeTapped(_ sender: UIButton) {
        likeButton.isSelected.toggle()
    }
    
    @objc
    private func cellTapped() {
        routing?()
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutoresizing(startDate, startCity, endDate, endCity, priceLabel, likeButton, horizontalSeparatorLine, verticalSeparatorLine)
        
        startDate.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(10)
        }
        
        startCity.snp.makeConstraints {
            $0.top.equalTo(startDate.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(10)
        }
        
        horizontalSeparatorLine.snp.makeConstraints {
            $0.centerY.equalTo(startDate)
            $0.leading.equalTo(startDate.snp.trailing).offset(10)
            $0.trailing.greaterThanOrEqualTo(endDate.snp.leading).offset(-10)
            $0.height.equalTo(2)
        }
        
        endDate.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalTo(horizontalSeparatorLine.snp.trailing).offset(5)
            $0.trailing.greaterThanOrEqualTo(verticalSeparatorLine.snp.leading).offset(-10)
        }
        
        endCity.snp.makeConstraints {
            $0.top.equalTo(endDate.snp.bottom).offset(5)
            $0.trailing.equalTo(verticalSeparatorLine.snp.leading).offset(-10)
        }
        
        verticalSeparatorLine.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(80)
            $0.width.equalTo(1)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.leading.greaterThanOrEqualTo(verticalSeparatorLine.snp.trailing).offset(5)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(priceLabel)
            $0.size.equalTo(32)
        }
        
    }
}
