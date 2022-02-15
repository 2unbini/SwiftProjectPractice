//
//  HorizontalScrollView.swift
//  SwipeView
//
//  Created by 권은빈 on 2022/02/15.
//

import UIKit

class HorizontalScrollView: BaseScrollView<[UIImage]> {
    
    let horizontalWidth: CGFloat
    let horizontalHeight: CGFloat
    
    init(horizontalWidth: CGFloat, horizontalHeight: CGFloat) {
        self.horizontalWidth = horizontalWidth
        self.horizontalHeight = horizontalHeight
        
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
    }
    
    override func bind(_ model: [UIImage]) {
        super.bind(model)
        
        setImages()
        updateScrollViewContentWidth()
    }
    
    private func setImages() {
        guard let images = model else { return }
        
        images
            .enumerated()
            .forEach {
                let imageView = UIImageView(image: $0.element)
                imageView.contentMode = .scaleAspectFit
                
                let xOffSet = horizontalWidth * CGFloat($0.offset)
                imageView.frame = CGRect(x: xOffSet,
                                         y: 0,
                                         width: horizontalWidth,
                                         height: horizontalHeight)
                addSubview(imageView)
            }
    }
    
    private func updateScrollViewContentWidth() {
        contentSize.width = horizontalWidth * CGFloat(model?.count ?? 1)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("open list")
    }
}
