//
//  HeaderCollectionReusableView.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/07.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    public func configure(with text: String) {
//        backgroundColor = .systemBackground
        label.text = text
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
