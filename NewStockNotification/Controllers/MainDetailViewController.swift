//
//  MainDetailViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import UIKit

class MainDetailViewController: UIViewController, UICollectionViewDelegate {
    
    private var sizeDataGuide: [String] = ["6.0", "6.5", "7.0", "7.5", "8.0", "8.5",
                                           "9.0", "9.5", "10.0", "10.5", "11.0", "11.5"]
    private var widthDataGuide: [String] = ["X-Narrow", "Narrow", "Standard", "Wide", "X-Wide"]
    private var width: Width!
    private var data = [String : [String:Bool]]()
    private var index = 0
    private let index2Width: [Int:String] = [0: "X-Narrow",
                                             1: "Narrow",
                                             2: "Standard",
                                             3: "Wide",
                                             4: "X-Wide"]
    private let widthButtonStack: UIStackView = UIStackView()
    private var widthButtons: [UIButton] = []
    private var shoesTextLabel: UILabel!
    private var shoesImage: UIImageView!
    
    private var sizeCollectionView: UICollectionView!
    private var widthCollectionView: UICollectionView!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewContoller()
        configureCollectionViews()
        
        initializeButtons()
        
        view.addSubview(widthButtonStack)
        for btn in self.widthButtons {
            widthButtonStack.addArrangedSubview(btn)
        }
    
        setupViews()
        
        // Add observer in controller(s) where you want to receive data
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.methodOfReceivedNotification(notification:)),
            name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    func initializeButtons() {
        for i in 0..<5 {
            let btn = UIButton()
            btn.setTitle(self.widthDataGuide[i], for: .normal)
            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            btn.setTitleColor(.black, for: .normal)
            btn.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            btn.layer.borderWidth = CGFloat(1.0)
            btn.tag = i
            let key = self.index2Width[i]!
            btn.isEnabled = self.data[key] != nil
            btn.backgroundColor = btn.isEnabled ? .white : .lightGray
            self.widthButtons.append(btn)
        }
    }
    
    @objc
    func buttonTapped(sender: UIButton!) {
        print(index)
        index = sender.tag
        sizeCollectionView.reloadData()
    }
    
    func configureViewContoller() {
        self.view.backgroundColor = .systemBackground
        self.title = "Detail view"
    }
    
    func configureScrollView() {
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
    }
    
    func configureShoesTextLabel() {
        self.shoesTextLabel = UILabel()
        self.shoesTextLabel.text = "Placeholder"
        self.shoesTextLabel.numberOfLines = 0
        self.shoesTextLabel.textAlignment = .center
        self.shoesTextLabel.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    func configureShoesImage() {
        self.shoesImage = UIImageView()
        self.shoesImage.layer.masksToBounds = true
        self.shoesImage.layer.cornerRadius = 8
        self.shoesImage.image = UIImage(systemName: "photo")
        self.shoesImage.contentMode = .scaleAspectFit
        
//        self.shoesImage.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.shoesImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            self.shoesImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            self.shoesImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            self.shoesImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
//            self.shoesImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2.0/5.0)
//        ])
    }
    
    func configureCollectionViews() {
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
        
        view.addSubview(contentView)
        contentView.addSubview(sizeCollectionView)
        view.addSubview(shoesImage)
        view.addSubview(shoesTextLabel)
    }
    
    // MARK: Method for receiving Data through Post Notification
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let obj = notification.object as? Int {
            index = obj
        }
    }
    
    func configureWidthButtonStack() {
        widthButtonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthButtonStack.topAnchor.constraint(equalTo: shoesTextLabel.bottomAnchor, constant: 30),
            widthButtonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            widthButtonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func setupViews() {
        
        shoesImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shoesImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            shoesImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            shoesImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            shoesImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            shoesImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 2.0/5.0)
        ])
        
        shoesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shoesTextLabel.topAnchor.constraint(equalTo: shoesImage.bottomAnchor, constant: 3),
            shoesTextLabel.leadingAnchor.constraint(equalTo: shoesImage.leadingAnchor, constant: 10)
        ])
        shoesTextLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        

        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        sizeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeCollectionView.topAnchor.constraint(equalTo: widthButtonStack.bottomAnchor, constant: 25),
            sizeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sizeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sizeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        configureWidthButtonStack()
        
    }
    
    func configure(_ url: String, _ name: String, _ width: Width) {
        print("configure get called")
        guard let url = URL(string: url) else { return }
        
        configureShoesTextLabel()
        configureShoesImage()
        
        self.shoesImage.load(url: url)
        self.shoesTextLabel.text = name
        self.width = width
        
        if let narrow = width.Narrow {
            var tempDict = [String:Bool]()
            for (k, v) in narrow.size {
                tempDict[k.replacingOccurrences(of: ",", with: ".")] = v
            }
            data["Narrow"] = tempDict
        }
        if let standard = width.Standard {
            var tempDict = [String:Bool]()
            for (k, v) in standard.size {
                tempDict[k.replacingOccurrences(of: ",", with: ".")] = v
            }
            data["Standard"] = tempDict
        }
        if let wide = width.Wide {
            var tempDict = [String:Bool]()
            for (k, v) in wide.size {
                tempDict[k.replacingOccurrences(of: ",", with: ".")] = v
            }
            data["Wide"] = tempDict
        }
        if let xnarrow = width.XNarrow {
            var tempDict = [String:Bool]()
            for (k, v) in xnarrow.size {
                tempDict[k.replacingOccurrences(of: ",", with: ".")] = v
            }
            data["X-Narrow"] = tempDict
        }
        if let xwide = width.XWide {
            var tempDict = [String:Bool]()
            for (k, v) in xwide.size {
                tempDict[k.replacingOccurrences(of: ",", with: ".")] = v
            }
            data["X-Wide"] = tempDict
        }
    }
}


extension MainDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.sizeDataGuide.count
        } else {
            return self.widthDataGuide.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            // print("sizeCV get called ever?")
            let cell = sizeCollectionView.dequeueReusableCell(
                withReuseIdentifier: SizeCollectionViewCell.identifier,
                for: indexPath) as! SizeCollectionViewCell
            
            let sizeName = self.sizeDataGuide[indexPath.row]
            let sizeExists = self.data[self.index2Width[index] ?? "Standard"]?[sizeName] == true
            
            cell.configure(with: sizeName, sizeExists)
            return cell
        } else {
            // print("widthCV get called ever?")
            let cell = widthCollectionView.dequeueReusableCell(
                withReuseIdentifier: WidthCollectionViewCell.identifier,
                for: indexPath) as! WidthCollectionViewCell
            
            let widthName = self.widthDataGuide[indexPath.row]
            let widthExists = self.data[widthName] != nil
            cell.configure(with: widthName, indexPath.row, widthExists)
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
            tempLabel.text = self.sizeDataGuide[indexPath.row]
            return CGSize(width: tempLabel.intrinsicContentSize.width + 40, height: 35)
        } else {
            tempLabel.text = self.widthDataGuide[indexPath.row]
            return CGSize(width: tempLabel.intrinsicContentSize.width + 20, height: 35)
        }
    }
}
