//
//  UIColor.swift
//  DYTV
//
//  Created by gsb on 2019/8/12.
//  Copyright © 2019年 seeworld. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(r:CGFloat, g: CGFloat , b: CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    
}
