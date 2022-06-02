//
//  TableViewCell.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/01.
//
import UIKit

class TableViewCell: UITableViewCell {

    public var memberNameLabel: UILabel!
    static let cellIdentifier = "cellIdentifier"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setUpLabel()
    }
    
    func setUpCell() {
        memberNameLabel = UILabel()
        contentView.addSubview(memberNameLabel)
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        memberNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setUpLabel() {
        memberNameLabel.textColor = .black
        memberNameLabel.font = UIFont.systemFont(ofSize: 18)
    }

}
