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
        sizeCollectionView.register(SizeCollectionViewCell.self,
                                    forCellWithReuseIdentifier: SizeCollectionViewCell.identifier)
        sizeCollectionView.register(HeaderCollectionReusableView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical
        widthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        widthCollectionView.delegate = self
        widthCollectionView.dataSource = self
        widthCollectionView.register(WidthCollectionViewCell.self, forCellWithReuseIdentifier: WidthCollectionViewCell.identifier)
        
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        view.addSubview(contentView)
        view.addSubview(imageView)
        view.addSubview(textLabel)
        contentView.addSubview(sizeCollectionView)
//        view.addSubview(widthCollectionView)
//        scrollView.addSubview(sizeCollectionView)
//        scrollView.addSubview(widthCollectionView)
//        scrollView.addSubview(imageView)
//        scrollView.addSubview(textLabel)
        // scrollView.addSubview(sizeCollectionView)
        // scrollView.addSubview(widthCollectionView)
        
        setupViews()
    }
    
    func setupViews() {
        let safeLayout = view.safeAreaLayoutGuide
        
//        scrollView.topAnchor.constraint(equalTo: safeLayout.topAnchor).isActive = true
//        scrollView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        //        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        //        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
//        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: safeLayout.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: safeLayout.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: safeLayout.heightAnchor, multiplier: 2.0/5.0).isActive = true
        
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10).isActive = true
        textLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = .brown
        contentView.topAnchor.constraint(equalTo: safeLayout.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
        
        sizeCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        sizeCollectionView.backgroundColor = .darkGray
        sizeCollectionView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 25).isActive = true
        sizeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        sizeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        sizeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

//        widthCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        widthCollectionView.topAnchor.constraint(equalTo: sizeCollectionView.bottomAnchor, constant: 25).isActive = true
//        widthCollectionView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
//        widthCollectionView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
//        widthCollectionView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
        
    }
    
    func configure(withUrl url: String, withName name: String) {
        guard let url = URL(string: url) else { return }
        imageView.load(url: url)
        textLabel.text = name
    }
}


extension MainDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("number of sections")
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of sections")
        
        if section == 0 {
            return self.sizeData.count
        } else {
            return self.widthData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            // print("sizeCV get called ever?")
            let cell = sizeCollectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.identifier, for: indexPath) as! SizeCollectionViewCell
            cell.configure(with: self.sizeData[indexPath.row])
            return cell
        } else {
            // print("widthCV get called ever?")
            let cell = widthCollectionView.dequeueReusableCell(withReuseIdentifier: WidthCollectionViewCell.identifier, for: indexPath) as! WidthCollectionViewCell
            cell.configure(with: self.widthData[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: HeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! HeaderCollectionReusableView
        let sectionTitle: String = indexPath.section == 0 ? "Size" : "Width"
        header.configure(with: sectionTitle)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tempLabel = UILabel()

        if indexPath.section == 0 {
            tempLabel.text = self.sizeData[indexPath.row]
            return CGSize(width: tempLabel.intrinsicContentSize.width + 40, height: 35)
        } else {
            tempLabel.text = self.widthData[indexPath.row]
            return CGSize(width: tempLabel.intrinsicContentSize.width + 20, height: 35)
        }
    }
}
