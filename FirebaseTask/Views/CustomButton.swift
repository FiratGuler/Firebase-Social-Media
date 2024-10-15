//
//  CustomButton.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit


class CustomButton : UIButton {
    
    
    init(titleName : String) {
        super.init(frame: CGRect.zero)
        
        self.setTitle(titleName, for: .normal)
        self.backgroundColor = .black
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 8
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
           didSet {
               self.backgroundColor = isHighlighted ? .gray : .black
           }
       }
    
   
}
