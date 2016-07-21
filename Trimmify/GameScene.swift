//
//  GameScene.swift
//  Trimmify
//
//  Created by Arvin Khamseh on 7/11/16.
//  Copyright (c) 2016 Arvin Khamseh. All rights reserved.
//

import SpriteKit

enum GameState {
    case Title, Ready, Playing, Stop, GameOver
}
enum BarState {
    case Up, Down, Stop
}


class GameScene: SKScene {
    
    
    var beard1:SKSpriteNode!
    var state: GameState = .Title
    // var state: BarState = .Up
    // var state: BarState = .Down
    // var state: BarState = .Stop
    var spot1:SKSpriteNode!
    var spot2:SKSpriteNode!
    var spot3:SKSpriteNode!
    var spot4:SKSpriteNode!
    var playButton:MSButtonNode!
    var restartButton:MSButtonNode!
    var healthBar:SKSpriteNode!
    var directionup = true
    var health: CGFloat = 1.0 {
        didSet {
            /* Scale health (even though it's called health it's really for the touching optimal zone)  bar between 0.0 -> 1.0 e.g 0 -> 100% */
            healthBar.xScale = health
        }
    }
    var scoreLabel: SKLabelNode!
    var points: CGFloat  = 0.0 {
        didSet {
            scoreLabel.text = String(points)
        }
    }
    var beardx: SKSpriteNode! {
        didSet {
            //  beardx.yScale = growth
        }
        
    }
    var levelTimerLabel: SKLabelNode!
    
    var levelTimerValue : Int = 500 {
        didSet {
            levelTimerLabel.text = "Time left: \(levelTimerValue)"
        }

    }
    var alphaspot1:CGFloat = 1
    var alphaspot2:CGFloat = 1
    var alphaspot3:CGFloat = 1
    var alphaspot4:CGFloat = 1
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        beard1 = childNodeWithName("beard1") as! SKSpriteNode
        spot1 = childNodeWithName("//spot1") as! SKSpriteNode
        spot2 = childNodeWithName("//spot2") as! SKSpriteNode
        spot3 = childNodeWithName("//spot3") as! SKSpriteNode
        spot4 = childNodeWithName("//spot4") as! SKSpriteNode
        healthBar = childNodeWithName("//healthBar") as! SKSpriteNode
        playButton = childNodeWithName("playButton") as! MSButtonNode
        restartButton = childNodeWithName("//restartButton") as! MSButtonNode
        scoreLabel = self.childNodeWithName("scoreLabel") as! SKLabelNode
        levelTimerLabel = self.childNodeWithName("//levelTimerLabel") as! SKLabelNode
        //scoreLabel.text = String(points)
        //Play button
        playButton.selectedHandler = {
            
            /* Start game */
            self.state = .Ready
        }
        restartButton.selectedHandler = {
            self.state = .Title
        }
        // beardx = childNodeWithName("beardx") as! SKSpriteNode
        
        
        //timer
        levelTimerLabel.fontColor = SKColor.blackColor()
        levelTimerLabel.fontSize = 40
        levelTimerValue = 60

        
        let wait = SKAction.waitForDuration(0.5) //change countdown speed here
        let block = SKAction.runBlock({
            [unowned self] in
            if self.levelTimerValue > 0{
                self.levelTimerValue -= 1
            }else{
                self.removeActionForKey("countdown")
            }
            })
        
        let sequence = SKAction.sequence([wait, block])
        self.runAction(SKAction.repeatActionForever(sequence))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if actionForKey("countdown") != nil {removeActionForKey("countdown")}
        
        if state == .GameOver || state == .Title {return}
        
        if state == .Ready {
            state = .Playing
        }
        
        
        for touch in touches {
            
            let positionInScene = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                print(name)
                switch name {
            //variable every time decrease
                case "spot1":
                    touchedNode.alpha -= 0.10
                case "spot2":
                    touchedNode.alpha -= 0.10
                case "spot3":
                    touchedNode.alpha -= 0.10
                case "spot4":
                    touchedNode.alpha -= 0.10
                default:
                    break;
                }
                if health >= 0.4 && health <= 0.6 {
                    points += 5
                    
                }
                else if health > 0.35 && health < 0.4 {
                    points += 2
                }
                else if health > 0.6 && health < 0.65{
                    points += 2
                }
                scoreLabel.text = String(points)
            }
            
        }
        
        /* write code for gameover state here
         if beard1.spot1,2,3,4 is longer beyond certain length ==
         
         
         gameOver()
         return
         }
         */
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if state != .Playing { return }
        
        
        
        if directionup {
            health += 0.01
            if health >= 1 {
                directionup = false
            }
        } else  {
            health -= 0.01
            if health <= 0 {
                directionup = true
            }
        }
        
        if health <= 0.50 {
            healthBar.color = SKColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }  else {
            healthBar.color = SKColor.redColor()
        }
        
        
        //growth += 1
        
        
    }
    
    //
    //
    //
    //        //Has the player run out of health?
    //        if health < 0 {
    //            //gameOver()
    //        } else if health > 0 {
    //            //gameOver()
    //        }
    
    
}






/*func gameOver()
 
 state = .GameOver
 for node:spot 1 in beard1{
 node.runAction(SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.50))
 }
 
 beard1.runAction(SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.50))
 
 playButton.selectionHandler = {
 let skView = self.view as SKView!
 
 let scene = GameScene(fileNamed:"GameScene") as GameScene!
 scene.scaleMode = .AspectFill
 
 skView.presentScene(scene)
 
 }
 */

