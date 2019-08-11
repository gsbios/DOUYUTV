//
//  HomeViewController.swift
//  DYTV
//
//  Created by seeworld on 2019/8/11.
//  Copyright © 2019 seeworld. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         setupUI()
    }
    

}

extension HomeViewController {
    
     fileprivate func setupUI() {
        
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

