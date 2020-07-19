//
//  ExchangeViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        creatFakeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavi()
    }
    
    // MARK: Lazy Get
    lazy var mainView: ExchangeView = {
        let view = ExchangeView()
        view.delegate = self
        return view
    }()
    
}

// MARK: - Data
extension ExchangeViewController {
    private func creatFakeData() {
        var dataSource: [[ArticleDetailModel]] = []
        for _ in 0..<12 {
            var monthData: [ArticleDetailModel] = []
            for _ in 0..<10 {
                monthData.append(creatMagazineData())
            }
            dataSource.append(monthData)
        }
        mainView.setupData(dataSource: dataSource)
    }
}

// MARK: - UI
extension ExchangeViewController {
    private func setupNavi() {
        navigationItem.title = "兑换"
        // 1.设置导航栏标题属性：设置标题颜色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        // 2.设置导航栏前景色：设置item指示色
        navigationController?.navigationBar.tintColor = UIColor.black
        // 3.设置导航栏半透明
        navigationController?.navigationBar.isTranslucent = false
        // 4.设置阴影
        navigationController?.navigationBar.getNaviLine()?.isHidden = false
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - ExchangeViewProtocol
extension ExchangeViewController: ExchangeViewProtocol {
    
    func exchangePoints() {
        
        //        let view = MagazineIssueHintView()
        //        UIApplication.shared.windows[0].addSubview(view)
        //        view.snp.makeConstraints { (make) in
        //            make.edges.equalToSuperview()
        //        }
        
        let alertVC = UIAlertController(title: "提示", message: "您当前的积分不足，无法进行兑换", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        okAction.setValue(UIColor.green, forKey: "titleTextColor")
        alertVC.addAction(okAction)
        navigationController?.present(alertVC, animated: true, completion: nil)
        
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIAlertAction.self, &count)
        
        for i in 0 ..< count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
    }
    
    func jumpToMagazineDetailView(with magazine: ArticleDetailModel) {
        let vc = ArticleDetailViewController()
        vc.entity = magazine
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: Fake Data
extension ExchangeViewController {
    private func creatMagazineData() -> ArticleDetailModel {
        var entity = ArticleDetailModel()
        entity.title = "重组人II型肿瘤坏死因子受体-抗体融合蛋白治疗中毒性表皮坏死松懈症的临床疗效观察"
        entity.author = "李伟；刘洁；杨志钢"
        entity.authorEmployer = "苏州大学附属第二医院；苏州大学附属第二医院；苏州大学附属第二医院；"
        entity.keyWords = "表皮坏死松懈症，中毒性；肿瘤坏死因子；治疗结果；生物制剂；"
        entity.chineseSummary = """
        【摘要】 目的 评价重组人Ⅱ型肿瘤坏死因子受体-抗体融合蛋白（rhTNFR：Fc）治疗由药物引起的中毒性表皮坏死松解症（TEN）的疗效及安全性。方法 2009—2018年于苏州大学附属第二医院等8个中心纳入22例TEN患者，男10例、女12例，年龄22 ~ 75岁。采用rhTNFR：Fc 25 mg/次皮下注射治疗，首剂加倍，每3天1次，连续治疗6 ~ 8次。治疗前及治疗后第4、7、10、13、16、19、22、25天评估患者药疹面积和严重程度指数（DASI）评分、DASI改善指数（DASI50、DASI75、DASI90）；微量样本多指标流式蛋白定量技术检测外周血及疱液TNF-α水平。治疗过程中监测患者体温、皮疹变化及肝肾功能，记录不良事件。统计分析采用重复测量方差分析、配对t检验及Pearson相关分析。结果 22例患者中，未合并感染的20例在首次治疗后24 ~ 72 h体温停止升高，48 ~120 h恢复正常。22例首次治疗后24 ~ 48 h控制水疱新发，48 ~ 96 h皮肤颜色由鲜红色转为暗紫色，2周后皮损基本恢复正常。治疗2 ~ 4周，19例肝功能异常患者丙氨酸转氨酶及天冬氨酸转氨酶水平恢复正常。治疗4 ~ 13 d，7例肾功能异常者肌酐、尿素氮得到控制。治疗过程中，22例患者DASI评分逐渐下降（F = 532.81，P＜0.01），从治疗前53.64 ± 8.67降至治疗25 d时的2.05 ± 1.21（t = 26.60，P < 0.001）。治疗第10天，22例（
        """
        return entity
    }
}
