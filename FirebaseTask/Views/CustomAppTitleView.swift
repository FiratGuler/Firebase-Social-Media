//
//  CustomAppTitleView.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 11.10.2024.
//
import UIKit
import SnapKit

class CustomAppTitleView : UIView {
    
    let viewSize = CGSize(width: 120, height: 50)
    let headingTitle = UILabel()
    let yearTitle = UILabel()
    
    init(heading: String, year: Int) {
        super.init(frame: CGRect.zero)
        
        headingTitle.text = heading
        yearTitle.text = "\(year)"
        
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headingTitle.text = "Default Heading"
        yearTitle.text = "2024"
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        headingTitle.text = "Default Heading"
        yearTitle.text = "2024"
        
        setupUI()
    }

    private func setupUI() {
       
        
        // Heading Title
        addSubview(headingTitle)
        headingTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        // Year Title
        addSubview(yearTitle)
        yearTitle.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(32)
            make.height.equalTo(headingTitle)
        }
    }
}
