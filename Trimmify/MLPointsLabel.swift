//
//  MLPointsLabel.swift
//  Trimmify
//
//  Created by Arvin Khamseh on 7/27/16.
//  Copyright © 2016 Arvin Khamseh. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MLPointsLabel: SKLabelNode {
    var number = 0
    init (num:Int){
        super.init()
        fontColor = UIColor.blackColor()
        fontName = "Helvetica"
        fontSize = 24.0
        number = num
        text = "\(num)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
        
    }
    
    func increment(){
        number += 1
        text = "\(number)"
    }
    func setTo(number:Int){
        //self.number = num
        text = "\(self.number)"
        
    }


}