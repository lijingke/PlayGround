//
//  MagazineIssueSelectView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

protocol MagazineIssueSelectProtocol: NSObjectProtocol {
    func selectSpecifications(entity: GoodsSpecificationsInfoEntity)
}

class MagazineIssueSelectView: UIView {
    
    // MARK: Property
    public weak var delegate: MagazineIssueSelectProtocol?
    
    private var yearsData: [GoodsSpecificationsInfoEntity] = []
    private var monthsData: [GoodsSpecificationsInfoEntity] = []
    private var isAnnual = false
    private var selectedEntity: GoodsSpecificationsInfoEntity?
    
    private var selectedRows = [Int?](repeating: nil, count: 2)
    
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

extension MagazineIssueSelectView {
    
    public func setupData(_ dataSource: [GoodsSpecificationsInfoEntity], isAnnual: Bool) {
        
        self.isAnnual = isAnnual
        
        var data: [GoodsSpecificationsInfoEntity] = []
        
        let operationSet = NSMutableSet()
        
        for operationObj in dataSource {
            operationSet.add(operationObj.year ?? 0)
        }
        
        operationSet.enumerateObjects { (obj, _) in
            let filterArray = dataSource.filter{$0.year == obj as? Int}
            var entity = GoodsSpecificationsInfoEntity()
            entity.year = obj as? Int
            entity.subArray = filterArray
            data.append(entity)
        }
        
        let sortData = data.sorted(by: {$0.year ?? 0 > $1.year ?? 0})
        
        self.yearsData = sortData
        self.monthsData = self.yearsData.first?.subArray ?? []
        
        self.pickerView.selectRow(0, inComponent: isAnnual == true ? 0 : 1, animated: true)
        self.pickerView(self.pickerView, didSelectRow: 0, inComponent:  isAnnual == true ? 0 : 1)
        
        if isAnnual == false {
            self.pickerView.selectRow(3, inComponent: 0, animated: true)
            self.pickerView.selectRow(3, inComponent: 1, animated: true)
        }
        
        if let firstColumnRow = selectedRows[0] {
            self.pickerView.selectRow(firstColumnRow, inComponent: 0, animated: true)
        }
        if let secondColumnRow = selectedRows[1] {
            self.pickerView.selectRow(secondColumnRow, inComponent: 1, animated: true)
        }
        
        pickerView.reloadAllComponents()
        
        confirmButton.sendActions(for: .touchUpInside)
        
    }
    
}

// MARK: - UIPickerViewDelegate
extension MagazineIssueSelectView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if isAnnual {
            let year = "\(yearsData[row].year ?? 0)年"
            return year
        } else {
            
            switch component {
            case 0:
                let year = "\(yearsData[row].year ?? 0)年"
                return year
            case 1:
                let month = "第\(monthsData[row].number ?? 0)期"
                return month
            default:
                return nil
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedRows[component] = row
        
        if isAnnual {
            let entity = yearsData[row]
            self.selectedEntity = entity
        } else {
            
            switch component {
            case 0:
                monthsData = yearsData[row].subArray ?? []
                pickerView.selectRow(0, inComponent: 1, animated: true)
                self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 1)
                pickerView.reloadAllComponents()
            case 1:
                let entity = monthsData[row]
                self.selectedEntity = entity
            default:
                break
            }
            
        }
        
    }
}

// MARK: - UIPickerViewDataSource
extension MagazineIssueSelectView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return isAnnual ? 1 : 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isAnnual {
            return yearsData.count
        } else {
            switch component {
            case 0:
                return yearsData.count
            case 1:
                return monthsData.count
            default:
                return 0
            }
        }
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
            hide()
            break
        case 1:
            if let entity = self.selectedEntity {
                self.delegate?.selectSpecifications(entity: entity)
                cancelBtn.sendActions(for: .touchUpInside)
            }
        default:
            break
        }
    }
    
    @objc private func hide() {
        self.removeFromSuperview()
        
    }
}
