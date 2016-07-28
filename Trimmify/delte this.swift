////
////  gamestate.swift
////  Trimmify
////
////  Created by Arvin Khamseh on 7/27/16.
////  Copyright © 2016 Arvin Khamseh. All rights reserved.
////
//
//import Foundation
//
//    class UserState {
//        var name: String = NSUserDefaults.standardUserDefaults().stringForKey("myName") ?? "User" {
//            didSet {
//                NSUserDefaults.standardUserDefaults().setObject(name, forKey:"myName")
//                // Saves to disk immediately, otherwise it will save when it has time
//                NSUserDefaults.standardUserDefaults().synchronize()
//            }
//        }
//        
//        var highScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("myHighScore") ?? 0 {
//            didSet {
//                NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey:"myHighScore")
//                // Saves to disk immediately, otherwise it will save when it has time
//                NSUserDefaults.standardUserDefaults().synchronize()
//            }
//        }
//}