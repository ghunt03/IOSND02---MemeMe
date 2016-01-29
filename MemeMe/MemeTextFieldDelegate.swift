//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Gareth Hunt on 25/01/2016.
//  Copyright © 2016 ghunt03. All rights reserved.
//

import Foundation
import UIKit
class MemeTextFieldDelegate :NSObject, UITextFieldDelegate {
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}