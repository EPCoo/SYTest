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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cidTextField.delegate = self
        self.Q3TextView.delegate = self
        self.popUpOneBtn.addItemsWithTitles(["很简单","比较简单","一般般","比较难","很难"])
        self.popUpTwoBtn.addItemsWithTitles(["80%以上","70%-80%","50%-70%","30%-50%","30%"])
        // Do any additional setup after loading the view.
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
    }

    @IBAction func finishBtnClick(sender: AnyObject) {
        print("提交")
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

