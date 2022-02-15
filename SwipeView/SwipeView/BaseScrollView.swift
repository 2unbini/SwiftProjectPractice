//
//  BaseScrollView.swift
//  SwipeView
//
//  Created by 권은빈 on 2022/02/15.
//

import UIKit

class BaseScrollView<Model>: UIScrollView {
    var model: Model? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    func bind(_ model: Model) {}
}
