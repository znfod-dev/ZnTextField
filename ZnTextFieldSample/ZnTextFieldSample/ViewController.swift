//
//  ViewController.swift
//  ZnTextFieldSample
//
//  Created by 박종현 on 09/08/2019.
//  Copyright © 2019 Znfod. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZnTextFieldDelegate {

    @IBOutlet weak var textField: ZnTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField.delegate = self
    }

    func ZnTextFieldShouldBeginEditing() -> Bool {
        print("ViewController ZnTextFieldShouldBeginEditing")
        return true
    }
    
    func ZnTextFieldDidBeginEditing() {
        print("ViewController ZnTextFieldDidBeginEditing")
        
    }
    
    func ZnTextFieldShouldEndEditing() -> Bool {
        print("ViewController ZnTextFieldShouldEndEditing")
        return true
    }
    
    func ZnTextFieldDidEndEditing() {
        print("ViewController ZnTextFieldDidEndEditing")
        let text = self.textField.text
        print("text : \(text)")
        
    }
    
    func ZnTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("ViewController textFieldShouldReturn")
        let _ = self.textField.resignFirstResponder()
        return true
    }

}

