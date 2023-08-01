//
//  EmptyCell.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit
import SnapKit

final class EmptyCell: UITableViewCell {

    struct Model {
        var height: CGFloat

        mutating func setHeight(height: CGFloat) {
            self.height = height
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHeight(_ height: CGFloat) {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }

    func configure(with model: Model) {
        contentView.snp.remakeConstraints { make in
            make.height.equalTo(model.height)
        }
    }

    
}
