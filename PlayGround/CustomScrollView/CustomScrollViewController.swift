//
//  CustomScrollViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/15.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.navigationItem.title = "CustomScrollView"
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        setupUI()
        countImageView.startAnimating()
    }
    
    lazy var backView: CustomScrollView = {
        let view = CustomScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        view.contentSize = CGSize(width: 320, height: 1000)
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var countImageView: UIImageView = {
        let view = UIImageView()
        let imageArray: [UIImage] = [UIImage(systemName: "square.and.arrow.up")!, UIImage(systemName: "square.and.arrow.up.fill")!,UIImage(systemName: "square.and.arrow.down")!,UIImage(systemName: "square.and.arrow.down.fill")!,]
        view.animationDuration = 4
        view.animationImages = imageArray
        view.animationRepeatCount = 1
        view.contentMode = .center
        return view
    }()
}

// MARK: - UI
extension CustomScrollViewController {
    private func setupUI() {
        
        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        redView.backgroundColor = UIColor(red: 0.815, green: 0.007, blue: 0.105, alpha: 1)
        
        let greenView = UIView(frame: CGRect(x: 150, y: 160, width: 150, height: 200))
        greenView.backgroundColor = UIColor(red: 0.494, green: 0.827, blue: 0.129, alpha: 1)
        
        let blueView = UIView(frame: CGRect(x: 40, y: 400, width: 200, height: 150))
        blueView.backgroundColor = UIColor(red: 0.29, green: 0.564, blue: 0.886, alpha: 1)
        
        let yellowView = UIView(frame: CGRect(x: 100, y: 600, width: 180, height: 150))
        yellowView.backgroundColor = UIColor(red: 0.972, green: 0.905, blue: 0.109, alpha: 1)
        view.addSubview(backView)
        backView.addSubview(redView)
        backView.addSubview(greenView)
        backView.addSubview(blueView)
        backView.addSubview(yellowView)
        
        
        view.addSubview(countImageView)
        countImageView.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
}
