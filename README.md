#前言
今天本来只想写个自适应宽度的一排button的,可是又觉得太简单了,所以玩心大起就加上了控制界面,期间被更改已创建好的View难住了,只能通过暴力手段进行更改了(删除重新创建)

如果有网友有需求的话可以发给我,也许我明天的博客主题就是你的需求

---
#效果图
![空隙全部相等](http://upload-images.jianshu.io/upload_images/1298596-b137cbed5dd600c5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#上代码
先创建一个LineButton.swift继承与NSObject的类然后加入一下代码:
```
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

```

然后在ViewController.swift里添加以下代码:

```
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
```
#效果
![按钮宽度固定自动对其](http://upload-images.jianshu.io/upload_images/1298596-f3f610e6d2f32259.gif?imageMogr2/auto-orient/strip)


###GitHub:https://github.com/Lafree317/Swift-LineButton
----
本人还是一只小菜鸡,不过是一只热心肠的菜鸡,如果有需要帮助或者代码中有更好的建议的话可以发邮件到lafree317@163.com中,我们一起进步XD
