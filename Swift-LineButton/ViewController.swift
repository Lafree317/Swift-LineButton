//
//  ViewController.swift
//  Swift-LineButton
//
//  Created by huchunyuan on 15/12/8.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

import UIKit
var dataArr:NSMutableArray = ["按钮1","按钮2","按钮3"]
class ViewController: UIViewController {
    // stroyBoard控件 (没啥用)
    @IBOutlet weak var myslider: UISlider!
    @IBOutlet weak var topTitle: UILabel!
    
    // 把类定义成属性
    let linebutton = LineButton()
    // view
    var  buttonView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 搭建view
        layoutView()
    }
    func layoutView(){
        topTitle.text = "按钮个数:\(Int(myslider.value))"
        // 先删除
        if buttonView != nil{
            buttonView.removeFromSuperview()
            buttonView = nil
        }
        // 再创建
        buttonView = linebutton.creatLineButton(dataArr, buttonSize: CGSizeMake(60, 50))
        buttonView.center = view.center
        self.view.addSubview(buttonView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // 添加按钮点击事件
    @IBAction func addButton(sender: UIButton) {
        if myslider.value == 5{
            return;
        }
        // slider.value+1
        myslider.value = myslider.value+1;
        // 数组添加值
        let str = "按钮\(dataArr.count+1)"
        dataArr.addObject(str)
        // 重新搭建view
        layoutView()
    }
    // 减少按钮点击时间
    @IBAction func subButton(sender: UIButton) {
        if myslider.value == 1{
            return;
        }
        myslider.value =  myslider.value-1;
        // 删除数组最后一个值
        dataArr.removeObjectAtIndex(dataArr.count-1)
        // 重新搭建view
        layoutView()
    }
}

