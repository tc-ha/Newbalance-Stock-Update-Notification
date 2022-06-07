//
//  CollectionViewCell.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/03.
//

import Foundation
import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    static let identifier = "SizeCollectionViewController"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        setupViews()
    }
    
    func setupViews() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with name: String) {
        label.text = name
    }
}
