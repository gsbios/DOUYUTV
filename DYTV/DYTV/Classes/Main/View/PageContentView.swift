//
//  PageContentView.swift
//  DYTV
//
//  Created by gsb on 2019/8/12.
//  Copyright © 2019年 seeworld. All rights reserved.
//

import UIKit

protocol pageContentViewDelegate : class {
    
    func selectPageTitleView(_ contentView : PageContentView , progress : CGFloat , sourceIndex : Int , targetInex : Int)
}

private let contentCellID = "ceontentCellID"

class PageContentView: UIView {

    fileprivate var subControllerViews : [UIViewController]
    fileprivate var mainControllerView : UIViewController
    weak var delegate : pageContentViewDelegate?
    
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建uUICOllectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()
    
    //自定义构造函数
    init(frame: CGRect , subControllerViews: [UIViewController] , mainViewContoller: UIViewController) {
        
        self.subControllerViews = subControllerViews
        self.mainControllerView = mainViewContoller
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK:- 设置UI界面
extension PageContentView {
    
    fileprivate func setupUI() {
        
        // 1.将所有的自控制器添加到父控制器中
        for childVc in subControllerViews {
            mainControllerView.addChild(childVc)
        }
        
        //2.添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK:- collectionViewDelegate
extension PageContentView : UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        

        // 0.判断是否是点击事件
        if  isForbidScrollDelegate {return}
        
        //1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int =  0
        var targetIndex : Int =  0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
//            1.计算progress  floor(x)返回不大于x的最大整数值。
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
//            2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
//            3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= subControllerViews.count {
                targetIndex = subControllerViews.count - 1
            }
            
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{ //右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //3.计算sourceInex
            sourceIndex = targetIndex + 1
            if sourceIndex >= subControllerViews.count {
                sourceIndex = subControllerViews.count - 1
            }
        }
        
        delegate?.selectPageTitleView(self, progress: progress, sourceIndex: sourceIndex, targetInex: targetIndex)
        
        
        
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subControllerViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
             view.removeFromSuperview()
        }
        
        let childVc = subControllerViews[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
}

//MARK:- 对外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(_ currentIndex : Int) {
        
        //1.记录需要进制执行f代理方法
        isForbidScrollDelegate = true
        
        //2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}
