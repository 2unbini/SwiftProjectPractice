//
//  ViewController.swift
//  SwipeView
//
//  Created by 권은빈 on 2022/02/15.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var horizontalScrollView: HorizontalScrollView = {
        let view = HorizontalScrollView(horizontalWidth: view.frame.width,
                                        horizontalHeight: view.frame.height)
        
        return view
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        addSubViews()
        makeConstraints()
        addTapGestureRecognizer()
    }

    func setupViews() {
        view.backgroundColor = .white
        
        let image1 = UIImage(named: "image1")!
        let image2 = UIImage(named: "image2")!
        let image3 = UIImage(named: "image3")!
        let image4 = UIImage(named: "image4")!
        
        horizontalScrollView.model = [image1, image2, image3, image4]
    }
    
    func addSubViews() {
        view.addSubview(horizontalScrollView)
        view.addSubview(settingButton)

    }
    
    func makeConstraints() {
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            horizontalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleTap(_:)))
        horizontalScrollView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let id = Int(horizontalScrollView.contentOffset.x / view.frame.width)
        
        print("tap: \(id)")
    }
    
    @objc func handleButtonTap(_ sender: Any) {
        if sender is UIButton {
            print("button tapped")
        }
    }
}

