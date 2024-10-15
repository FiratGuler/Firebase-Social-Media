//
//  DownloadVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 10.10.2024.
//

import UIKit
import SnapKit
import SDWebImage

class DownloadVC: UIViewController {

    
    private let infoLabel = UILabel()

    private let collectionImageView = UIImageView()
    private var imageArray : [PostModel] = []
    private var filteredImageArray : [String] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    var userEmail : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        appendImageArray()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(leftBarButtonTapped))
        
        // Info Label
        infoLabel.text = Constants.DownloadVCCosntast.infoTitle.rawValue
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.numberOfLines = 2
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(42)
        }
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2.4
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        

        collectionView.collectionViewLayout = layout

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview()
        }
    }

    
    private func appendImageArray() {
        FirestoreManager.shared.fetchFlowData { result in
            switch result {
            case .success(let success):
                self.imageArray = success
                self.filterImageById()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func filterImageById() {
        filteredImageArray.removeAll()
        
        for imageItem in imageArray {
            if imageItem.postedBy == userEmail {
                self.filteredImageArray.append(imageItem.image)
            }
        }
        collectionView.reloadData()
    }
    
    // MARK: - Selector
    
    @objc private func leftBarButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DownloadVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        setupItemImage(cell: item, urlString: filteredImageArray[indexPath.item])
        return item
    }
    
    private func setupItemImage(cell: UICollectionViewCell,urlString: String) {
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        if let imageUrl = URL(string: urlString) {
            imageView.sd_setImage(with: imageUrl)
        }
        
        
        cell.contentView.addSubview(imageView)
    }
    
    
}

extension DownloadVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageUrlString = filteredImageArray[indexPath.item]
        
        if let imageUrl = URL(string: selectedImageUrlString) {
            downloadImage(from: imageUrl)
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Image download failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
        
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
        }.resume()
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Image save error: \(error.localizedDescription)")
        } else {
            print("Image saved successfully!")
        }
    }
}


