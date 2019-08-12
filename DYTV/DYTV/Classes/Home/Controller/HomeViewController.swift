//
//  HomeViewController.swift
//  DYTV
//
//  Created by seeworld on 2019/8/11.
//  Copyright © 2019 seeworld. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    

//MARK:-懒加载
    fileprivate lazy var pageView : pageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: KscreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = pageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {
        
//        1.确定内容的frame
        let contentH = KscreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: KscreenW, height: contentH)
        
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for  index in 0..<4 {
           let childvc = UIViewController()
           childvc.view.backgroundColor = UIColor(r: CGFloat(arc4random() % 255), g: CGFloat(arc4random() % 255), b: CGFloat(arc4random() % 255))
           childVcs.append(childvc)
        }
        
        let contentView = PageContentView(frame: contentFrame, subControllerViews: childVcs, mainViewContoller: self)
        contentView.delegate = self
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

         setupUI()
    }
    

}

extension HomeViewController {
    
     fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false;
        self.view.addSubview(pageView)
        self.view.addSubview(pageContentView)
        setupnavigationBar()
    }
    
    fileprivate func setupnavigationBar() {
        
        //1.设置左导航栏
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "logo"), for: .normal)
        logoBtn.setImage(UIImage(named: "logo"), for: .highlighted)
        logoBtn.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: logoBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        //设置右导航栏
        let size = CGSize(width: 35, height: 35)
        let historyItem = UIBarButtonItem(imageView: "image_my_history", highImagename: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageView: "btn_search", highImagename: "btn_search_clicked", size: size)
        
        let scanItem = UIBarButtonItem(imageView: "Image_scan", highImagename: "Image_scan_click", size: size)
        
        self.navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
        
        
    }

}

extension HomeViewController : pageTitleViewDelegate {
    
    func selectCurrentTitle(_ titleView: pageTitleView, selectIndex: Int) {
        pageContentView.setCurrentIndex(selectIndex);
    }

}

extension HomeViewController :pageContentViewDelegate {
    func selectPageTitleView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetInex: Int) {
        
        pageView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetInex)
    }
    
    

}

