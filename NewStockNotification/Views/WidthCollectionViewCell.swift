//
//  CollectionViewCell.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/03.
//

import Foundation
import UIKit

class WidthCollectionViewCell: UICollectionViewCell {
    static let identifier = "WidthCollectionViewController"
    
    private let label: UIButton = {
        let label = UIButton()
//        label.text = "Test"
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.layer.borderWidth = CGFloat(1.0)
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.setTitleColor(.black, for: .normal)
        label.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return label
    }()
    
    public var switches = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        setupViews()
        
        // MARK:Set data for Passing Data through Post Notification
        let objToBeSent = switches
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: objToBeSent)
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
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
    
    func configure(with name: String, _ tag: Int, _ widthExists: Bool) {
        label.setTitle(name, for: .normal)
        label.tag = tag
        if !widthExists {
            label.backgroundColor = .lightGray
            label.isEnabled = false
        }
    }
    
    @objc
    func buttonTapped(sender: UIButton!) {
        switches = sender.tag
    }
}
