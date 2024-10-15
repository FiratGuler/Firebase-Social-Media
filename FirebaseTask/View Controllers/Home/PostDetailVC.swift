//
//  PostDetailVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 8.10.2024.
//

import UIKit
import SnapKit


class PostDetailVC: UIViewController {
    
    var postId : String?
    let tableView = UITableView()
    let commentTextField = CustomTextField(placeholder: "Comment...")
    let sendButton = UIButton()
    
    var postsArray : [PostModel] = []
    var commentArray : [Comment] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        firebaseFetchData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        commentArray.removeAll()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
       
        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
                make.bottom.equalTo(100)
            
        }
        // comment textField
        view.addSubview(commentTextField)
        commentTextField.snp.makeConstraints { make in
            make.bottom.equalTo(-52)
            make.left.equalTo(32)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(32)
        }
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.systemBlue, for: .normal)
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(commentTextField)
            make.left.equalTo(commentTextField.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(commentTextField)
            make.width.equalTo(60)
        }
        sendButton.addTarget(self, action: #selector(sendCommentTapped), for: .touchUpInside)
    }
    
    private func firebaseFetchData() {
        FirestoreManager.shared.fetchFlowData { result  in
            switch result {
            case .success(let data):
                self.postsArray = data
                self.commentArrayConfigure()
                self.tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    
    }

    private func commentArrayConfigure() {
        for post in postsArray {
            if post.postId == postId {
                
                commentArray = post.comments
            }
        }
    }

    // MARK: - Selecotor
    
    @objc private func sendCommentTapped() {
        
        guard let id = postId else { return }
        guard let commentText = commentTextField.text else { return }
        
       
        FirestoreManager.shared.addComment(postId: id, commentText: commentText) { result in
            switch result {
            case .success():
                self.commentTextField.text = "" 
                self.firebaseFetchData()
            case .failure(let error):
                print(error)
            }
        }
    }
 

}

extension PostDetailVC : UITableViewDelegate { }

extension PostDetailVC : UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = commentArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(user.postedBy) : \(user.comment)"
        return cell
    }
    
}
