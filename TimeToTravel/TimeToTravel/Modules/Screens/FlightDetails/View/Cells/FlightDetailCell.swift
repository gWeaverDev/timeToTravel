//
//  FlightDetailCell.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

final class FlightDetailCell: UICollectionViewCell {
    
    weak var delegate: FlightDetailsDelegate?
    
    private var ticketModel: Ticket?
    
    private let flightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let startFlightImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrow.up.circle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemGreen
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let endFlightImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrow.down.circle")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemRed
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let startDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let endDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let startCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let endCity: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .red
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 5
        return button
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
    
    func fill(with model: Ticket) {
        self.ticketModel = model
        flightLabel.text = "\(model.startCity) - \(model.endCity)"
        startDate.text = model.startDate
        endDate.text = model.endDate
        startCity.text = model.startCity
        endCity.text = model.endCity
        buyButton.setTitle(model.price, for: .normal)
        likeButton.isSelected = model.isLiked
    }
    
    private func cellAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func addTargets() {
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
    }
    
    @objc
    private func likeTapped(_ sender: UIButton) {
        delegate?.likeButtonTapped()
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutoresizing(flightLabel, startFlightImage, startDate, startCity, endFlightImage, endDate, endCity, buyButton, likeButton)
        
        flightLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.lessThanOrEqualTo(likeButton.snp.leading).inset(20)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerY.equalTo(flightLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(28)
            $0.height.equalTo(24)
        }
        
        startFlightImage.snp.makeConstraints {
            $0.top.equalTo(flightLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.size.equalTo(26)
        }
        
        startDate.snp.makeConstraints {
            $0.centerY.equalTo(startFlightImage.snp.centerY)
            $0.leading.equalTo(startFlightImage.snp.trailing).offset(10)
        }
        
        startCity.snp.makeConstraints {
            $0.centerY.equalTo(startFlightImage.snp.centerY)
            $0.leading.equalTo(startDate.snp.trailing).offset(10)
        }
        
        endFlightImage.snp.makeConstraints {
            $0.top.equalTo(startFlightImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.size.equalTo(26)
        }
        
        endDate.snp.makeConstraints {
            $0.centerY.equalTo(endFlightImage.snp.centerY)
            $0.leading.equalTo(endFlightImage.snp.trailing).offset(10)
        }
        
        endCity.snp.makeConstraints {
            $0.centerY.equalTo(endFlightImage.snp.centerY)
            $0.leading.equalTo(endDate.snp.trailing).offset(10)
        }
        
        buyButton.snp.makeConstraints {
            $0.top.equalTo(endDate.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }
    }
}
