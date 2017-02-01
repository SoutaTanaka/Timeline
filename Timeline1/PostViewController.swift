//
//  ViewController.swift
//  Timeline1
//
//  Created by 田中颯太 on 2016/12/23.
//  Copyright © 2016年 田中颯太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostViewController: UIViewController, UITextViewDelegate {
    
    var usersString: String!
    var titleString: String!
    var bunString: String!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bunTextField: UITextView!
    @IBOutlet var label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bunTextField.delegate = self
        label.text = "文字を入力"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func OK(){
        if userTextField.text != "" && titleTextField.text != "" && bunTextField.text != ""{
            let ref = FIRDatabase.database().reference().childByAutoId()
            usersString = userTextField.text
            titleString = titleTextField.text
            bunString =  bunTextField.text
            ref.setValue(["Users": usersString, "title": titleString, "bun": bunString])
            
            navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
                   }
        
        if userTextField.text == "" || titleTextField.text == "" || bunTextField.text == ""{
            
            let alert: UIAlertController = UIAlertController(title: "内容がありません", message: "文字を入力してください", preferredStyle:  UIAlertControllerStyle.alert)
            
            //
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            
            alert.addAction(defaultAction)
            
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    //テキストビューが変更された
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            label.text = "文字を入力"
            
        }else{
            label.text = ""
        }
    }
    
    
}

