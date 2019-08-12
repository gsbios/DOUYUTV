//
//  LiveViewController.swift
//  DYTV
//
//  Created by seeworld on 2019/8/11.
//  Copyright © 2019 seeworld. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class LiveViewController: UIViewController {

    //MARK:-懒加载
    fileprivate lazy var titleView : liveTitleView = {
        
        let frame = CGRect(x: 0.0 , y: kStatusBarH + kNavigationBarH, width: KscreenW, height: kTitleViewH)
        let titles = ["英雄联盟","王者农药","DNF","QQ飞车","吃鸡","传奇"]
        let titleView = liveTitleView(frame: frame, titles: titles)
        titleView.backgroundColor = UIColor.lightGray
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
        setupUI()
    }
}

extension LiveViewController {
    
    fileprivate func setupUI() {
      //添加titleView
        self.view.addSubview(titleView)
    }
    
}
