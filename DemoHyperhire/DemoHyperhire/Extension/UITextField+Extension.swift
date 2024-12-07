//
//  UITextField+Extension.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import Foundation
import UIKit

extension UITextField {
    func setAttributePlaceHolder(title: String) {
        var placeHolder = NSMutableAttributedString()
        
        // Set the Font
        placeHolder = NSMutableAttributedString(string:title, attributes: [NSAttributedString.Key.font: AppFont.font(type: .Regular, size: 15.0)])
        
        // Set the color
        //        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: textPlaceHolderColor, range:NSRange(location:0,length:title.count))
        
        // Add attribute
        self.attributedPlaceholder = placeHolder
        
    }
    
    func setAttributesPlaceHolder_Color(placeHolderString: String, placeHolderColor: String = "C6C6C6", fontSize: CGFloat = 24.0) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderString, attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: placeHolderColor)!, NSAttributedString.Key.font: AppFont.font(type: .Regular, size: fontSize)])
    }
    
    func setAttributesPlaceHolder_Color_CompareTxt(placeHolderString: String, placeHolderColor: String = "C6C6C6") {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderString, attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: placeHolderColor)!, NSAttributedString.Key.font: AppFont.font(type: .Regular, size: 10.0)])
    }
    
    
    func setLeftViewMode() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.leftViewMode = .always
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension String {
    var lines: [String] { return self.components(separatedBy: NSCharacterSet.newlines)}
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
