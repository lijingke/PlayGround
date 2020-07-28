//
//  ExchangeView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeView: UIView {
    
    // MARK: Property
    public weak var delegate: ExchangeViewProtocol?
    private var monthly: Int = 1
    private var isAnnual: Bool = false
    private var dataSource: [[ArticleDetailModel]]?
    private var monthlyData: [GoodsSpecificationsInfoEntity]?
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        tabScrollView.contentSize = tableContentView.frame.size
        scrollView.contentSize = contentView.frame.size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Get
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "中华皮肤科杂志电子版激活码（年）"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.medium(18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var requiredPoints: UILabel = {
        let label = UILabel()
        label.text = "3000积分"
        label.textColor = UIColor(hex: 0xF0A044)
        label.font = UIFont.regular(17)
        return label
    }()
    
    lazy var chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "选择兑换期刊"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.regular(17)
        return label
    }()
    
    lazy var chooseLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE3E8FF)
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var segmentBar: SegmentBar = {
        let vc = SegmentBar()
        vc.delegate = self
        return vc
    }()
    
    lazy var chooseBtn: ChooseView = {
        let view = ChooseView()
        view.clickAction = { () in
            UIApplication.shared.windows[0].addSubview(self.selectView)
            self.selectView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        return view
    }()
    
    lazy var selectView: MagazineIssueSelectView = {
        let view = MagazineIssueSelectView()
        view.delegate = self
        return view
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF7F7F7)
        return view
    }()
    
    lazy var tabScrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.bounces = false
        view.isPagingEnabled = true
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.tag = 1
        return view
    }()
    
    lazy var tableViewOne: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.tag = 1
        table.delegate = self
        table.dataSource = self
        table.register(ExchangeInstructionsCell.self, forCellReuseIdentifier: ExchangeInstructionsCell.identifier)
        table.separatorStyle = .none
        table.estimatedRowHeight = 320
        return table
    }()
    
    lazy var tableViewTwo: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.tag = 2
        table.delegate = self
        table.dataSource = self
        table.register(MonthlyTableViewCell.self, forCellReuseIdentifier: MonthlyTableViewCell.identifier)
        table.register(MagazineInstructionCell.self, forCellReuseIdentifier: MagazineInstructionCell.identifier)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var tableContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.bounces = false
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.tag = 0
        return view
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
extension ExchangeView: MagazineIssueSelectProtocol {
    func selectSpecifications(entity: GoodsSpecificationsInfoEntity) {
        var title = "\(entity.year ?? 0)年"
        if let num = entity.number {
            title.append(contentsOf: " 第\(num)期")
        }
        
        if isAnnual, let months = entity.subArray{
            self.monthlyData = months
            self.tableViewTwo.reloadData()
        }
        chooseBtn.setupData(title)
    }
}

// MARK: - UI
extension ExchangeView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(scrollView)
        addSubview(exchangeBtn)

        scrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(exchangeBtn.snp.top)
        }
        exchangeBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(45)
        }
        
        scrollView.addSubview(contentView)
                
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(requiredPoints)
        contentView.addSubview(chooseLine)
        contentView.addSubview(chooseLabel)
        contentView.addSubview(chooseBtn)
        contentView.addSubview(separatorLine)
        contentView.addSubview(segmentBar)
        contentView.addSubview(tabScrollView)
        
        coverImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(snp.width).multipliedBy(0.533)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.bottom).offset(20.5)
            make.left.equalToSuperview().offset(15)
        }
        requiredPoints.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
        }
        chooseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(requiredPoints.snp.bottom).offset(20.5)
            make.left.equalTo(requiredPoints)
        }
        chooseLine.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(chooseLabel)
            make.size.equalTo(CGSize(width: 110, height: 7.5))
        }
        chooseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(chooseLine.snp.bottom).offset(14.5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(45)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(chooseBtn.snp.bottom).offset(28.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(11.5)
        }
        segmentBar.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        tabScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(322)
        }
        
        tabScrollView.addSubview(tableContentView)
        tableContentView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth * 2)
            make.height.equalToSuperview()
        }

        tableContentView.addSubview(tableViewOne)
        tableContentView.addSubview(tableViewTwo)
        tableViewOne.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        tableViewTwo.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(tableViewOne)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
        }

        
    }
}

// MARK: - Event
extension ExchangeView {
    @objc private func exchangeAction() {
        delegate?.exchangePoints()
    }
}

// MARK: - Data
extension ExchangeView {
    
    public func setupMagazine(magazine: MagazineInfoEntity) {
                
        coverImageView.sd_setImage(with: URL(string: magazine.coverURL ?? ""), placeholderImage: UIImage(named: "img")) { [weak self] (image, _, _, _) in
            let cropImage = image?.crop(ratio: 1.875, cropType: .top)
            self?.coverImageView.image = cropImage
        }
        
        titleLabel.text = magazine.magazineTitle
        
        let attribute = NSMutableAttributedString()
        let needPoints = NSMutableAttributedString(string: "\(magazine.needPoints ?? 0)积分   ")
        needPoints.addAttributes([.font: UIFont.regular(17)!, .foregroundColor: UIColor(hex: 0xF0A044)], range: NSRange(location: 0, length: needPoints.length))
        attribute.append(needPoints)
        let priceString = NSMutableAttributedString(string: "¥250")
        priceString.addAttributes([.strikethroughStyle: NSNumber(value: 1), .font: UIFont.regular(17)!, .foregroundColor: UIColor(hex: 0xA4A4A4)], range: NSRange(location: 0, length: priceString.length))
        attribute.append(priceString)
        requiredPoints.attributedText = attribute
        
        isAnnual = magazine.isAnnual
    }
    
    public func setupData(dataSource: [[ArticleDetailModel]], monthlyData: [GoodsSpecificationsInfoEntity] = []) {
        self.dataSource = dataSource
        selectView.setupData(monthlyData, isAnnual: isAnnual)
        if isAnnual {
            self.monthlyData = monthlyData
        }
        tableViewTwo.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ExchangeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 2 {
            let indexRow = isAnnual ? indexPath.row - 1 : indexPath.row
            if let entity = dataSource?[monthly][indexRow] {
                delegate?.jumpToMagazineDetailView(with: entity)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ExchangeView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return 1
        case 2:
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
        switch tableView.tag {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeInstructionsCell.identifier, for: indexPath)
            return cell
        case 2:
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
extension ExchangeView: MonthlyChooseProtocol {
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
        tableViewTwo.reloadData()
        Loading.hideLoading(from: self)
        Loading.showToastOnSuccess(to: self)
    }
}

// MARK: - UIScrollViewDelegate
extension ExchangeView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UITableView.self) {
            if self.scrollView.contentOffset.y == 0 {
                let offsetY = scrollView.contentOffset.y
                if offsetY > 0 {
                    let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                    self.scrollView.setContentOffset(bottomOffset, animated: true)
                }
            }
            return
        }
        if scrollView.tag == 1 {
            let value = scrollView.contentOffset.x / scrollView.bounds.size.width
            segmentBar.setScrollValue(value: value)
        }
        
    }
}

// MARK: - SegmentBarDelegate
extension ExchangeView: SegmentBarDelegate {
    func segmentBarDidSelect(fromIndex: NSInteger) {
        tabScrollView.setContentOffset(CGPoint(x: CGFloat(fromIndex) * tabScrollView.bounds.width, y: tabScrollView.contentOffset.y), animated: true)
    }
}
