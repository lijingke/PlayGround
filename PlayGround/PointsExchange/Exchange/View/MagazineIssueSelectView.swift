//
//  MagazineIssueSelectView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MagazineIssueSelectView: UIView {
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hide))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: nil, action: nil)
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x4E61FB), for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x4E61FB), for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xC8C8C8)
        return view
    }()
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
}

// MARK: - UIPickerViewDelegate
extension MagazineIssueSelectView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "YY是个大SB"
    }
}

// MARK: - UIPickerViewDataSource
extension MagazineIssueSelectView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
}

// MARK: - UI
extension MagazineIssueSelectView {
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(contentView)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(confirmButton)
        contentView.addSubview(separatorLine)
        contentView.addSubview(pickerView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(304)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 30, height: 21))
        }
        confirmButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(cancelBtn)
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(cancelBtn)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(cancelBtn.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
    }
}

extension MagazineIssueSelectView {
    
    @objc private func btnAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("取消")
            break
        case 1:
            print("确定")
            break
        default:
            break
        }
    }
    
    @objc private func hide() {
//        UIView.animate(withDuration: 0.3, animations: { [weak self] () in
//            self?.removeFromSuperview()
//        }) { (complete) in
//
//        }
        self.removeFromSuperview()

    }
}
