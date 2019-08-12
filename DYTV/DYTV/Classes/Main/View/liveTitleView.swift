//
//  liveTitleView.swift
//  DYTV
//
//  Created by gsb on 2019/8/12.
//  Copyright © 2019年 seeworld. All rights reserved.
//

import UIKit

private let kscrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class liveTitleView: UIView {

    
    fileprivate var titles : [String]
    
    fileprivate lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
        
    }()
    
    //自定义构造方法
     init(frame: CGRect , titles: [String]){
        self.titles = titles
        super.init(frame: frame);
        
        //setup UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension liveTitleView {
    
    fileprivate func setupUI() {
        //建立label 栏
        setupTitle()
        
        //添加scrollView
        scrollView.frame = bounds
        addSubview(self.scrollView)
    }
    
    fileprivate func setupTitle() {
        
        
        let labelW : CGFloat = frame.size.width / CGFloat(self.titles.count)
        let labelH : CGFloat = frame.size.height - kscrollLineH
        let labelY : CGFloat = 0
        for (index, title) in self.titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            let labelX = CGFloat(index) * labelW

            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(titleLabel);
        }
    }
}
