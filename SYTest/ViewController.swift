//
//  ViewController.swift
//  SYTest
//
//  Created by 王顺 on 16/6/11.
//  Copyright © 2016年 ws. All rights reserved.
//

import Cocoa
import Alamofire

class ViewController: NSViewController,NSTextFieldDelegate,NSTextViewDelegate {
    @IBOutlet weak var cidTextField: NSTextField!
    @IBOutlet weak var popUpOneBtn: NSPopUpButton!
    @IBOutlet weak var popUpTwoBtn: NSPopUpButton!
    @IBOutlet var Q3TextView: NSTextView!
    let q3Arr = ["老师讲的不错，非常好",
                 "还行吧",
                 "讲的太快了，有点听不过来",
                 "自己还需要多努力！",
                 "加油！加油！加油！",
                 "老师讲的太棒了，自是自己有点跟不上。。。",
                 "再接再厉！！！",
                 "好！",
                 "非常好！",
                 "没谁了。。。。",
                 ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cidTextField.delegate = self
        self.Q3TextView.delegate = self
        self.popUpOneBtn.addItemsWithTitles(["很简单","比较简单","一般般","比较难","很难"])
        self.popUpTwoBtn.addItemsWithTitles(["80%以上","70%-80%","50%-70%","30%-50%","30%"])
        
    }

    override func controlTextDidChange(obj: NSNotification) {
        print(self.cidTextField.stringValue)
    
    }
    @IBAction func popOneUpBtnClick(sender: AnyObject) {
        let one = sender as! NSPopUpButton
        print(one.itemTitles[one.indexOfSelectedItem])
        
    }
    @IBAction func popUpTwoBtnClick(sender: AnyObject) {
        let two = sender as! NSPopUpButton
        print(two.itemTitles[two.indexOfSelectedItem])
    }
    func textDidChange(notification: NSNotification) {
        print(self.Q3TextView.string)
    }
    
    @IBAction func randomBtnClick(sender: AnyObject) {
        print("随机生成")
        self.popUpOneBtn.selectItemAtIndex(random()%5)
        self.popUpTwoBtn.selectItemAtIndex(random()%5)
        self.Q3TextView.string = self.q3Arr[random()%self.q3Arr.count]
    }

    @IBAction func finishBtnClick(sender: AnyObject) {
        print("提交")
        
        if self.cidTextField.stringValue.isEmpty{
            let alert = NSAlert.init()
            alert.messageText = "请输入班级的cid"
            alert.beginSheetModalForWindow(self.view.window!, completionHandler: nil)
            return
        }
        let q1 = "1#" + String(self.popUpOneBtn.indexOfSelectedItem + 1)
        let q2 = "2#" + String(self.popUpTwoBtn.indexOfSelectedItem + 6)
        let dic = ["question1":q1, "question2":q2, "desc3":"", "flag":"login"]
        
        let baseUrl = ""
        let url = baseUrl + "/index.php?cid=" + self.cidTextField.stringValue
        let header = ["User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36"]
        Alamofire.request(.POST, url, parameters: dic, encoding: .URL, headers: header).responseJSON { (response) in
            let string = String.init(data: response.data!, encoding: NSUTF8StringEncoding)
            let range = string?.rangeOfString("你一的意见我们已经收到，会把结果汇总给讲师")
            if range != nil {
                let alert = NSAlert.init()
                alert.messageText = "你的意见我们已经收到，会把结果汇总给讲师"
                alert.beginSheetModalForWindow(self.view.window!, completionHandler: nil)
            } else {
                let alert = NSAlert.init()
                alert.messageText = "提交失败！！！！！"
                alert.beginSheetModalForWindow(self.view.window!, completionHandler: nil)

            }
        }
        
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

