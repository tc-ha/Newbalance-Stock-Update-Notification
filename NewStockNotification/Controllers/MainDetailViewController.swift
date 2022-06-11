//
//  MainDetailViewController.swift
//  NewStockNotification
//
//  Created by taechan on 2022/06/02.
//

import UIKit

class MainDetailViewController: UIViewController, UICollectionViewDelegate {
    
    var sizeData: [String] = ["6.0", "6.5", "7.0",
                              "7.5", "8.0", "8.5",
                              "9.0", "9.5", "10.0",
                              "10.5", "11.0", "11.5"]
    
    var widthData: [String] = ["X-Narrow", "Narrow", "Standard",
                               "Wide", "X-Wide"]
    
    var width: Width!
    
    var data = [String : [String:Bool]]()
    
    var switches = 0
    
    let map: [Int:String] = [0: "X-Narrow",
                             1: "Narrow",
                             2: "Standard",
                             3: "Wide",
                             4: "X-Wide"]
    
    let buttonStack: UIStackView = {
        let buttonStack = UIStackView()
        return buttonStack
    }()
    
    var widthButtons: [UIButton] = []
    
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
        
        configureCollectionViews()
        contentView.addSubview(sizeCollectionView)
        initializeButtons()
        
        view.addSubview(buttonStack)
        for btn in self.widthButtons {
            buttonStack.addArrangedSubview(btn)
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
            btn.setTitle(self.widthData[i], for: .normal)
            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            btn.setTitleColor(.black, for: .normal)
            btn.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            btn.layer.borderWidth = CGFloat(1.0)
            btn.tag = i
            let key = self.map[i]!
            btn.isEnabled = self.data[key] != nil
            btn.backgroundColor = btn.isEnabled ? .white : .lightGray
            self.widthButtons.append(btn)
        }
    }
    
    @objc
    func buttonTapped(sender: UIButton!) {
        print(switches)
        switches = sender.tag
        sizeCollectionView.reloadData()
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
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .vertical
        widthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        widthCollectionView.delegate = self
        widthCollectionView.dataSource = self
        widthCollectionView.register(WidthCollectionViewCell.self, forCellWithReuseIdentifier: WidthCollectionViewCell.identifier)
        
        view.addSubview(contentView)
        view.addSubview(imageView)
        view.addSubview(textLabel)
    }
    
    // MARK: Method for receiving Data through Post Notification
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let obj = notification.object as? Int {
            switches = obj
        }
    }
    
    func setupViews() {
        let safeLayout = view.safeAreaLayoutGuide
        
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
        
        
//        contentView.backgroundColor = .lightGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: safeLayout.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor).isActive = true
        
        sizeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sizeCollectionView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 25).isActive = true
        sizeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        sizeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        sizeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30).isActive = true
//        buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func configure(_ url: String, _ name: String, _ width: Width) {
        guard let url = URL(string: url) else { return }
        self.imageView.load(url: url)
        self.textLabel.text = name
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
        
        print(data)
    }
}


extension MainDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.sizeData.count
        } else {
            return self.widthData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            // print("sizeCV get called ever?")
            let cell = sizeCollectionView.dequeueReusableCell(
                withReuseIdentifier: SizeCollectionViewCell.identifier,
                for: indexPath) as! SizeCollectionViewCell
            
            let sizeName = self.sizeData[indexPath.row]
            let sizeExists = self.data[self.map[switches] ?? "Standard"]?[sizeName] == true
            
            cell.configure(with: sizeName, sizeExists)
            return cell
        } else {
            // print("widthCV get called ever?")
            let cell = widthCollectionView.dequeueReusableCell(
                withReuseIdentifier: WidthCollectionViewCell.identifier,
                for: indexPath) as! WidthCollectionViewCell
            
            let widthName = self.widthData[indexPath.row]
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
            tempLabel.text = self.sizeData[indexPath.row]
            return CGSize(width: tempLabel.intrinsicContentSize.width + 40, height: 35)
        } else {
            tempLabel.text = self.widthData[indexPath.row]
            return CGSize(width: tempLabel.intrinsicContentSize.width + 20, height: 35)
        }
    }
}
