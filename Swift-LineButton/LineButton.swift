//
//  LineButton.swift
//  Swift-LineButton
//
//  Created by huchunyuan on 15/12/8.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit

class LineButton: NSObject {
    
    // button数组
    var buttonArr:NSMutableArray = []
    // 创建view方法
    func creatLineButton(dataArr:NSMutableArray,buttonSize:CGSize) ->UIView {
        // 最底层容器view
        let myView = UIView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,buttonSize.height))
        // 计算空隙 空隙 = (总宽 - 所有button的宽)/空隙个数
        let gap = CGFloat((myView.frame.size.width - (buttonSize.width*CGFloat(dataArr.count)))/(CGFloat(dataArr.count+1)))
        for index in 0..<dataArr.count {
            // 定义button
            let button = UIButton(type: UIButtonType.System)
            // 给frame
            button.frame = CGRectMake((CGFloat(index+1))*gap + ((CGFloat(index)*buttonSize.width)), 0, buttonSize.width, buttonSize.height)
            // 赋值
            button.setTitle(dataArr[index] as? String, forState: UIControlState.Normal)
            button.tintColor = UIColor.whiteColor()
            button.backgroundColor = UIColor.lightGrayColor()
            button.setTitle("选中", forState: UIControlState.Selected)
            button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Selected)
            button.titleLabel?.font = UIFont.systemFontOfSize(20)
            // 同一个点击方法 根据传值和数组区分
            button.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            // 添加到view上
            myView.addSubview(button)
            // 加入button数组
            buttonArr.addObject(button)
        }
        // 返回值
        return myView
    }
    // 按钮点击事件
    func buttonClick(button:UIButton){
        for b in buttonArr{
            // 遍历按钮数组,如果相同就改成选中状态,不相同就取消选中状态
            if (b as! UIButton) == button{
                (b as! UIButton).selected = true
            }else{
                (b as! UIButton).selected = false
            }
        }
        print(button.titleLabel!.text!)
    }
}
