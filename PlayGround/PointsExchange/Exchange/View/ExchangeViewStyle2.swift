//
//  ExchangeViewStyle2.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/28.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

class ExchangeViewStyle2: UIView {
    
    // MARK: Property
    public weak var delegate: ExchangeViewProtocol?
    private var monthly: Int = 1
    private var isAnnual: Bool = false
    private var dataSource: [[ArticleDetailModel]]?
    private var monthlyData: [GoodsSpecificationsInfoEntity]?
    private var currentIndex: Int = 0
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Get
    lazy var headView: ExchangeTableHeadView = {
        let view = ExchangeTableHeadView()
        return view
    }()
    
    lazy var segmentBar: SegmentClickBar = {
        let vc = SegmentClickBar()
        vc.delegate = self
        return vc
    }()
    
    lazy var selectView: MagazineIssueSelectView = {
        let view = MagazineIssueSelectView()
        view.delegate = self
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(ExchangeInstructionsCell.self, forCellReuseIdentifier: ExchangeInstructionsCell.identifier)
        table.register(MonthlyTableViewCell.self, forCellReuseIdentifier: MonthlyTableViewCell.identifier)
        table.register(MagazineInstructionCell.self, forCellReuseIdentifier: MagazineInstructionCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var exchangeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("立即兑换", for: .normal)
        btn.setTitle("暂无库存", for: .disabled)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(UIImage.getImage(from: UIColor(hex: 0x5161F9)), for: .normal)
        btn.setBackgroundImage(UIImage.getImage(from: UIColor(hex: 0xD5D9FF)), for: .disabled)
        btn.titleLabel?.font = UIFont.regular(17)
        btn.addTarget(self, action: #selector(self.exchangeAction), for: .touchUpInside)
        return btn
    }()
    
}

// MARK: - MagazineIssueSelectProtocol
extension ExchangeViewStyle2: MagazineIssueSelectProtocol {
    func selectSpecifications(entity: GoodsSpecificationsInfoEntity) {
        var title = "\(entity.year ?? 0)年"
        if let num = entity.number {
            title.append(contentsOf: " 第\(num)期")
        }
        
        if isAnnual, let months = entity.subArray{
            self.monthlyData = months
            self.tableView.reloadData()
        }
        headView.chooseBtn.setupData(title)
    }
}
// MARK: - SegmentClickBarDelegate
extension ExchangeViewStyle2: SegmentClickBarDelegate {
    func segmentBarDidSelect(toIndex: Int) {
        currentIndex = toIndex
        tableView.reloadData()
    }
}
// MARK: - UI
extension ExchangeViewStyle2 {
    private func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        addSubview(exchangeBtn)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(exchangeBtn.snp.top)
        }
        exchangeBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(45)
        }
        
        let height = headView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.headView.frame
        frame.size.height = height
        headView.frame = frame
        headView.setNeedsLayout()
        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
}

// MARK: - Event
extension ExchangeViewStyle2 {
    @objc private func exchangeAction() {
        delegate?.exchangePoints()
    }
}

// MARK: - Data
extension ExchangeViewStyle2 {
    
    public func setupMagazine(magazine: MagazineInfoEntity) {
        
        headView.coverImageView.sd_setImage(with: URL(string: magazine.coverURL ?? ""), placeholderImage: UIImage(named: "img")) { [weak self] (image, _, _, _) in
            let cropImage = image?.crop(ratio: 1.875, cropType: .top)
            self?.headView.coverImageView.image = cropImage
        }
        
        headView.titleLabel.text = magazine.magazineTitle
        
        let attribute = NSMutableAttributedString()
        let needPoints = NSMutableAttributedString(string: "\(magazine.needPoints ?? 0)积分   ")
        needPoints.addAttributes([.font: UIFont.regular(17)!, .foregroundColor: UIColor(hex: 0xF0A044)], range: NSRange(location: 0, length: needPoints.length))
        attribute.append(needPoints)
        let priceString = NSMutableAttributedString(string: "¥250")
        priceString.addAttributes([.strikethroughStyle: NSNumber(value: 1), .font: UIFont.regular(17)!, .foregroundColor: UIColor(hex: 0xA4A4A4)], range: NSRange(location: 0, length: priceString.length))
        attribute.append(priceString)
        headView.requiredPoints.attributedText = attribute
        
        isAnnual = magazine.isAnnual
    }
    
    public func setupData(dataSource: [[ArticleDetailModel]], monthlyData: [GoodsSpecificationsInfoEntity] = []) {
        self.dataSource = dataSource
        selectView.setupData(monthlyData, isAnnual: isAnnual)
        if isAnnual {
            self.monthlyData = monthlyData
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ExchangeViewStyle2: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexRow = isAnnual ? indexPath.row - 1 : indexPath.row
        if let entity = dataSource?[monthly][indexRow] {
            delegate?.jumpToMagazineDetailView(with: entity)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return segmentBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDataSource
extension ExchangeViewStyle2: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentIndex {
        case 0:
            return 1
        case 1:
            let month = monthly - 1
            if month >= 0, let data = dataSource?[month] {
                return isAnnual ? data.count + 1 : data.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeInstructionsCell.identifier, for: indexPath)
            return cell
        case 1:
            if indexPath.row == 0 && isAnnual == true {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MonthlyTableViewCell.identifier, for: indexPath) as? MonthlyTableViewCell else { return UITableViewCell() }
                cell.delegate = self
                cell.setupData(self.monthlyData ?? [])
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazineInstructionCell.identifier, for: indexPath) as? MagazineInstructionCell else { return UITableViewCell() }
                let indexRow = isAnnual ? indexPath.row - 1 : indexPath.row
                let entity = dataSource?[monthly][indexRow]
                cell.setupData(entity: entity ?? ArticleDetailModel())
                return cell
            }
        default:
            return UITableViewCell()
        }
        
    }
}

// MARK: - MonthlyChooseProtocol
extension ExchangeViewStyle2: MonthlyChooseProtocol {
    func monthDidSelected(_ month: GoodsSpecificationsInfoEntity) {
        
        for (index, item) in self.monthlyData!.enumerated() {
            if item.id == month.id {
                self.monthlyData![index].isSelected.toggle()
            } else {
                self.monthlyData![index].isSelected = false
            }
        }
        
        print(month)
        
        Loading.showLoading(to: self)
        tableView.reloadData()
        Loading.hideLoading(from: self)
        Loading.showToastOnSuccess(to: self)
    }
}
