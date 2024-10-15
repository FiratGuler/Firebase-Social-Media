//
//  CustomCell.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 8.10.2024.
//

import UIKit
import SnapKit




class CustomCell : UITableViewCell {
    
    var downloadButtonClick : (() -> ())?
    
    let userMailLabel = UILabel()
    let image = UIImageView()
    let dateTitle = UILabel()
    let seeCommentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        // user title
        
        userMailLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(userMailLabel)
        userMailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(22)
        }
        
        // Image
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(userMailLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(image.snp.width).multipliedBy(0.6)
        }
        
        // date title
        dateTitle.font = UIFont.systemFont(ofSize: 16)
        dateTitle.textAlignment = .right
        contentView.addSubview(dateTitle)
        dateTitle.snp.makeConstraints { make in
            make.top.left.right.height.equalTo(userMailLabel)
        }
        
        //See Comment
        seeCommentLabel.text = "Tap for see comments"
        
        contentView.addSubview(seeCommentLabel)
        seeCommentLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(12)
            make.height.right.equalTo(dateTitle)
        }
        
    }

}
