//
//  MAValidator.swift
//  CookMe
//
//  Created by BackendServTestUser on 2/7/16.
//  Copyright © 2016 MartinApostolov. All rights reserved.
//

import Foundation

@objc class MAValidator: NSObject{
//    
//    class func `new`() -> MAValidator {
//        return MAValidator()
//    }
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
}


