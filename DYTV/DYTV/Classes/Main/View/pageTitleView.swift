//
//  pageTitleView.swift
//  DYTV
//
//  Created by seeworld on 2019/8/11.
//  Copyright © 2019 seeworld. All rights reserved.
//

import UIKit

//MARK:- 定义协议
protocol pageTitleViewDelegate : class {
    func selectCurrentTitle(_ titleView : pageTitleView ,selectIndex : Int)
    
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kPageTitleViewH : CGFloat = 40

class pageTitleView: UIView {
    
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : pageTitleViewDelegate?
   
    //MARK:-懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    //title顶部线view
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine  = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
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
        
        //添加UIscrollView
        addSubview(scrollView)
        scrollView.frame = bounds
//       2.添加title对应的label
        setupTitlesLabels()
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
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
            
//            4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
//            5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
//        1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollView
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: 2)
        
        //设置scrollViewLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
}

extension pageTitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer){
        
        //获取当前的label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        //如果是重复点击同一个title 那么直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新的label的下标值
        currentIndex = currentLabel.tag
        
        //滚动条位置f发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        delegate?.selectCurrentTitle(self, selectIndex: currentIndex)
        
    }
}

//MARK:-对外暴露的方法
extension pageTitleView{
    
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int , targetIndex : Int)  {
        
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.u颜色的渐变
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 + colorDelta.0 * progress, g: kSelectColor.1 + colorDelta.1 * progress, b: kSelectColor.2 + colorDelta.2 * progress)
        //3.2变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的Index
        currentIndex = targetIndex
        
        
    }
}
