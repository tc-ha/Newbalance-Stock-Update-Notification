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
        label.layer.borderWidth = CGFloat(1.0)
        label.layer.borderColor = UIColor.lightGray.cgColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
//        contentView.clipsToBounds = true
        setupViews()
    }
    
    func setupViews() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with name: String, _ sizeExists: Bool) {
        label.text = name
        if !sizeExists {
            label.backgroundColor = .lightGray
        } else {
            label.backgroundColor = .white
        }
        
        print(sizeExists)
    }
}
