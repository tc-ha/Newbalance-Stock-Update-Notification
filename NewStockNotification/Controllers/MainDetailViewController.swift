//
//  MainDetailViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import UIKit

class MainDetailViewController: UIViewController, UICollectionViewDelegate {
    
    var sizeData: [String] = ["6", "6.5", "7",
                              "7.5", "8", "8.5",
                              "9", "9.5", "10",
                              "10.5", "11", "11.5"]
    var widthData: [String] = ["X-Narrow", "Narrow", "Standard",
                               "Wide", "X-Wide"]
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var sizeCollectionView: UICollectionView!
    private var widthCollectionView: UICollectionView!
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        return scroll
    }()
    
    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Detail view"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        sizeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        sizeCollectionView.register(SizeCollectionViewCell.self, forCellWithReuseIdentifier: SizeCollectionViewCell.identifier)
        
        view.addSubview(scrollView)
        scrollView.addSubview(textLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(sizeCollectionView)
        //        view.addSubview(textLabel)
        //        view.addSubview(imageView)
        //        view.addSubview(collectionView)
        setupViews()
    }
    
    func setupViews() {
        let safeLayout = view.safeAreaLayoutGuide
        
        scrollView.topAnchor.constraint(equalTo: safeLayout.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        //        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        //        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10).isActive = true
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3).isActive = true
        textLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        
        sizeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sizeCollectionView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 25).isActive = true
        sizeCollectionView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor, constant: 10).isActive = true
        sizeCollectionView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor, constant: 10).isActive = true
        sizeCollectionView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
    }
    
    func configure(withUrl url: String, withName name: String) {
        guard let url = URL(string: url) else { return }
        imageView.load(url: url)
        textLabel.text = name
    }
    
}


extension MainDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sizeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.identifier, for: indexPath) as! SizeCollectionViewCell
        cell.configure(with: self.sizeData[indexPath.row])
        cell.backgroundColor = .systemRed
        return cell
    }
    
    
}
