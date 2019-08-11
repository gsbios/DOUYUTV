//
//  UIBarButtonItem-Extension.swift
//  DYTV
//
//  Created by seeworld on 2019/8/11.
//  Copyright © 2019 seeworld. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
//    class func creatItem(imageName: String,highImageName: String,size:CGSize) -> UIBarButtonItem {
//
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: .zero, size: size)
//
//        return UIBarButtonItem(customView: btn);
//
//    }
    
    //便利构造函数
    convenience init(imageView: String, highImagename: String = "" ,size: CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageView), for: .normal)
        
        if highImagename != "" {
            btn.setImage(UIImage(named: highImagename), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
