//
//  Utility.swift
//  Notepad
//
//  Created by Khayal Alrubaie on 2023-01-10.
//

import Foundation
import UIKit

class Utility: UITextField {
    
    static func styleTextField (_ textfield: UITextField) {
        
        
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 73/255, blue: 99/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
    }
    
   
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


