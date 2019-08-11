//
//  pageTitleView.swift
//  DYTV
//
//  Created by seeworld on 2019/8/11.
//  Copyright © 2019 seeworld. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2


class pageTitleView: UIView {
    
    let titles : [String]
    
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()

     //自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension pageTitleView {
    
    fileprivate func setupUI() {
        
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
//        1.添加title对应的label
        setupTitlesLabels()
    }
    
    fileprivate func setupTitlesLabels() {
        
        let labelW = frame.size.width / CGFloat(titles.count)
        let labelH = frame.size.height - kScrollLineH
        let labelY = 0
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            
            let labelX = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: CGFloat(labelY), width: labelW, height: labelH)
            
            scrollView.addSubview(label)
        }
    }
}
