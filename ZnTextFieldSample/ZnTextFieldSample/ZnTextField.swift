//
//  ZnTextField.swift
//  ZnTextFieldSample
//
//  Created by 박종현 on 12/08/2019.
//  Copyright © 2019 Znfod. All rights reserved.
//


import UIKit

@IBDesignable
class ZnTextField: UIView {
    
    weak var delegate: ZnTextFieldDelegate?
    
    var hintLabel:UILabel!
    var inputTextfield:UITextField!
    var line:UIView!
    
    @IBInspectable var textSize: CGFloat = 0
    @IBInspectable var hint: String = ""
    @IBInspectable var lineHeight:CGFloat = 5
    
    @IBInspectable var lineColor:UIColor = UIColor.black
    @IBInspectable var textColor:UIColor = UIColor.black
    @IBInspectable var titleColor:UIColor = UIColor.black
    @IBInspectable var hintColor:UIColor = UIColor.lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("frame : \(frame)")
        
        draw(frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("aDecoder : \(aDecoder)")
    }
    
    override func draw(_ rect: CGRect) {
        print("rect : \(rect)")
        
        setBottomLine(rect)
        setHintLabel(rect)
        setTextField(rect)
    }
    private func setBottomLine(_ rect: CGRect) {
        let frame = CGRect.init(x: 0, y: rect.height-lineHeight, width: rect.width, height: lineHeight)
        if self.line == nil {
            self.line = UIView.init(frame: frame)
            self.line.backgroundColor = lineColor
            self.addSubview(self.line)
        }
    }
    private func setTextField(_ rect: CGRect) {
        let height = (rect.height-lineHeight)/2
        let frame = CGRect.init(x: 0, y: height, width: rect.width, height: height)
        if self.inputTextfield == nil {
            self.inputTextfield = UITextField.init(frame: frame)
            self.inputTextfield.font = UIFont.systemFont(ofSize: self.textSize)
            self.inputTextfield.delegate = self
            self.inputTextfield.borderStyle = .none
            self.inputTextfield.textColor = textColor
            self.addSubview(self.inputTextfield)
        }
    }
    private func setHintLabel(_ rect: CGRect) {
        let height = (rect.height-lineHeight)/2
        let frame = CGRect.init(x: 0, y: height, width: rect.width, height: height)
        if self.hintLabel == nil {
            self.hintLabel = UILabel.init(frame: frame)
            self.hintLabel.font = UIFont.systemFont(ofSize: self.textSize)
            self.hintLabel.text = hint
            self.hintLabel.textColor = hintColor
            self.addSubview(self.hintLabel)
        }
    }
    func setTitle() {
        print("show")
        var rect = self.inputTextfield.frame
        let height = rect.height
        rect.origin.y = rect.origin.y - height
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.hintLabel.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                self.hintLabel.frame = rect
                self.hintLabel.textColor = self.titleColor
            })
        }
    }
    func setHint() {
        print("hide")
        if self.textExist() {
            
        }else {
            let rect = self.inputTextfield.frame
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, animations: {
                    self.hintLabel.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self.hintLabel.frame = rect
                    self.hintLabel.textColor = self.hintColor
                })
            }
        }
    }
    // inputTextField 에 Text가 있으면 true 없으면 false
    func textExist() -> Bool{
        if self.inputTextfield.text == "" {
            return false
        }else {
            return true
        }
    }
    
    override func resignFirstResponder() -> Bool {
        self.inputTextfield.resignFirstResponder()
        return true;
    }
    
    var text:String{
        get {
            return self.inputTextfield.text!
        }
        set {
            self.inputTextfield.text = newValue
        }
    }
    
}

extension ZnTextField:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("ZnTextField textFieldShouldBeginEditing")
        let result = delegate?.ZnTextFieldShouldBeginEditing()
        self.setTitle()
        return result!
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("ZnTextField textFieldDidBeginEditing")
        delegate?.ZnTextFieldDidBeginEditing()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("ZnTextField textFieldShouldEndEditing")
        let result = delegate?.ZnTextFieldShouldEndEditing()
        self.setHint()
        return result!
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ZnTextField textFieldDidEndEditing")
        delegate?.ZnTextFieldDidEndEditing()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("ZnTextField textFieldDidEndEditing")
        let result = delegate?.ZnTextFieldShouldReturn(self.inputTextfield)
        return result!
    }
}

protocol ZnTextFieldDelegate: class {
    func ZnTextFieldShouldBeginEditing() -> Bool
    func ZnTextFieldDidBeginEditing()
    func ZnTextFieldShouldEndEditing() -> Bool
    func ZnTextFieldDidEndEditing()
    func ZnTextFieldShouldReturn(_ textField: UITextField) -> Bool
    
}
