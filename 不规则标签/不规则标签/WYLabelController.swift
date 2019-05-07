//
//  WYLabelController.swift
//  不规则标签
//
//  Created by study on 2019/4/29.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
 /// 获取屏幕宽
let width = UIScreen.main.bounds.size.width
 /// 获取屏幕宽
let height = UIScreen.main.bounds.size.height

typealias LabelProtocol = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

class WYLabelController: UIViewController {
    
    private var colltionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
//         getData()
    }
}

extension WYLabelController {
    /// 初始化 UICollectionView 并注册 UICollectionViewCell
    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        // 必须写，用来自动计算行高
        layout.estimatedItemSize = CGSize(width: 100, height: 30)
        
        colltionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
        
        //注册一个cell
        colltionView! .register(WYLabelCell.self, forCellWithReuseIdentifier:"cell")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        colltionView?.backgroundColor = UIColor.white
        
        self.view.addSubview(colltionView!)
    }
}

extension WYLabelController: LabelProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WYLabelCell
        cell.label.text = "wangjie"
        
        return cell
    }
}


