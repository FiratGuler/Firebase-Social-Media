//
//  ViewController.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage
import FirebaseRemoteConfig
import FirebaseCrashlytics

/*
 E-posta “neonapps.co” ile bitmelidir ancak başka e-posta adresleri de kaydedilebilir.
 bunu yaparsam eposta gönderemem söylemeyi unutma!
 sürekli View oluşturmak doğru mu birden çok view problem yaratır mı
 */

class HomeVC: UIViewController {
    
    var postArray : [PostModel] = []
    
    let tableView = UITableView(frame: .zero)
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
        fetchRemoteConfig()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTappedRightBarButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "exclamationmark.icloud.fill"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTappedLeftBarButton))
        
        titleLabel.text = "Waaow"
        titleLabel.isHidden = true
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
        }
        
        tableViewSetup()
        
    }
    
    private func tableViewSetup() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func fetchData() {
        FirestoreManager.shared.fetchFlowData { result in
            switch result {
            case .success(let data):
                self.postArray = data
                self.tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func fetchRemoteConfig() {
        RemoteConfigManager.shared.fetchRemoteConfig { result in
            switch result {
            case .success():
                
                let title = RemoteConfigManager.shared.getTitle()
                let isTitleHidden = RemoteConfigManager.shared.getIsTitleHidden()
                let year = RemoteConfigManager.shared.getYear()
                
                DispatchQueue.main.async {
                    self.titleLabel.isHidden = isTitleHidden
                    self.titleLabel.text = "\(title) \(year)"
                }
                
                
            case .failure(let failure):
                switch failure {
                    
                case .fetchFailed(let message):
                    print("Fetch error: \(message)")
                case .activationFailed(let message):
                    print("Activation error: \(message)")
                case .invalidData(let message):
                    print("Invalid data: \(message)")
                }
            }
        }
    }
    
    // MARK: Selector
    
    @objc private func didTappedRightBarButton(){
        let user = Auth.auth().currentUser?.email
        
        let downloadVC = DownloadVC()
        let navController = UINavigationController(rootViewController: downloadVC)
        navController.modalPresentationStyle = .fullScreen
        downloadVC.userEmail = user
        self.present(navController,animated: true)
    }
    
    @objc private func didTappedLeftBarButton(){
        Crashlytics.crashlytics().log("Kullanıcı çökme düğmesine bastı!")
        
        let array = [1, 2, 3]
        let _ = array[10]
    }
    
    
}

extension HomeVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.selectionStyle = .none
        cell.userMailLabel.text = postArray[indexPath.row].postedBy
        cell.image.sd_setImage(with: URL(string: postArray[indexPath.row].image))
        cell.dateTitle.text = postArray[indexPath.row].date
        
        return cell
    }
}

extension HomeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let imageHeight = (screenWidth * 0.8) * 0.6
        let totalHeight = 22 + imageHeight + 22 + 40 + 72
        return totalHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = PostDetailVC()
        detailVC.postId = postArray[indexPath.row].postId
        self.present(detailVC, animated: true)
    }
}


