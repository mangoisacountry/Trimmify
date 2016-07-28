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



class GameScene: SKScene {
    
    var touchedNode: SKNode!
    var beard1:SKSpriteNode!
    var state: GameState = .Title
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
  
    var growth: CGFloat = 1.0 {
        didSet {
        spot1.yScale = growth
        }
        
    }
    var levelTimerLabel: SKLabelNode!
    
    var levelTimerValue : Int = 500 {
        didSet {
            levelTimerLabel.text = " \(levelTimerValue)"
            levelTimerLabel.fontColor = SKColor.blueColor()
        }

    }
    var alphaspot1:CGFloat = 1
    var alphaspot2:CGFloat = 1
    var alphaspot3:CGFloat = 1
    var alphaspot4:CGFloat = 1
    var sinceTouch : CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0/60.0 /* 60 FPS */
    //var maskNode: SKNode?
    var cropNode: SKCropNode = SKCropNode()

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        beard1 = childNodeWithName("beard1") as! SKSpriteNode
        addPointsLabels()
        spot1 = childNodeWithName("//spot1") as! SKSpriteNode
        spot2 = childNodeWithName("//spot2") as! SKSpriteNode
        spot3 = childNodeWithName("//spot3") as! SKSpriteNode
        spot4 = childNodeWithName("//spot4") as! SKSpriteNode
        healthBar = childNodeWithName("//healthBar") as! SKSpriteNode
        playButton = childNodeWithName("playButton") as! MSButtonNode
        restartButton = childNodeWithName("//restartButton") as! MSButtonNode
        levelTimerLabel = self.childNodeWithName("//levelTimerLabel") as! SKLabelNode
        //Play button
        playButton.selectedHandler = {
            
            /* Start game */
            self.state = .Playing
        }
        restartButton.selectedHandler = {
            self.state = .Title
        }
        // beardx = childNodeWithName("beardx") as! SKSpriteNode
        
        
        //timer
        levelTimerLabel.fontColor = SKColor.blackColor()
        levelTimerLabel.fontSize = 40
        levelTimerValue = 75

        
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
    
        loadHighscore()
        
        
    
    }
    func loadHighscore(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let highscoreLabel = childNodeWithName("highscoreLabel")as! MLPointsLabel
        highscoreLabel.setTo(defaults.integerForKey("highscore"))
    }
    func addPointsLabels(){
        let pointsLabel = MLPointsLabel(num: 0)
        pointsLabel.name = "pointsLabel"
        let highscoreLabel = MLPointsLabel(num: 0)
        highscoreLabel.name = "highscoreLabel"
        pointsLabel.position = CGPointMake(200.0, 200)
        highscoreLabel.position = CGPointMake(235, 235)
        addChild(pointsLabel)
        let highscoreTextLabel = SKLabelNode(text:"High")
        highscoreTextLabel.fontColor = UIColor.blackColor()
        highscoreTextLabel.fontSize = 14.0
        highscoreTextLabel.fontName = "Helvetica"
        highscoreTextLabel.position = CGPointMake(200, 200)
        highscoreLabel.addChild(highscoreTextLabel)
        addChild(highscoreLabel)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         //Called when a touch begins
        if actionForKey("countdown") != nil {removeActionForKey("countdown")}
        
        if state == .GameOver || state == .Title {return}
        
        if state == .Ready {
            state = .Playing
        }
        
     let pointsLabel = childNodeWithName("pointsLabel") as! MLPointsLabel
        pointsLabel.increment()
        for touch in touches {
        
            spot1.size.height -= 0.5
            
            spot2.size.height -= 0.2
            
            spot3.size.height -= 0.2
            
            spot4.size.height -= 0.5
            
            
            let positionInScene = touch.locationInNode(self)
            touchedNode = self.nodeAtPoint(positionInScene)
            if let name = touchedNode.name
            {
                print(name)
                switch name {
            //variable every time decrease
                case "spot1":
                    spot1.size.height -= 10
                    spot1.position.y += 1
                case "spot2":
                    spot2.size.height -= 10
                    spot2.position.y += 1
                case "spot3":
                    spot3.size.height -= 10
                    spot3.position.y += 1
                case "spot4":
                    spot4.size.height -= 10
                    spot4.position.y += 1
                default:
                    break;
                }
//                if health >= 0.4 && health <= 0.6 {
//                    points += 5
//                    
//                }
//                else if health > 0.35 && health < 0.4 {
//                    points += 2
//                }
//                else if health > 0.6 && health < 0.65{
//                    points += 2
//                }
            }
            
        }

    }
    
    
    override func update(currentTime: CFTimeInterval) {
        
        if state == .Ready {
            spot1.size.height += 0.2
            spot1.position.y -= 0.03
            spot2.size.height += 0.2
            spot2.position.y -= 0.1

            spot3.size.height += 0.2
            spot3.position.y -= 0.1
            spot4.size.height += 0.2

            spot4.position.y -= 0.03

        }
        /* Called before each frame is rendered */
        if state != .Playing { return }
        
        spot1.size.height += 0.5
        spot1.position.y -= 0.025
        
        spot2.size.height += 0.2
        spot2.position.y -= 0.1
        
        spot3.size.height += 0.2
        spot3.position.y -= 0.1
        
        spot4.size.height += 0.5
        spot4.position.y -= 0.025
        
    playButton.hidden = true
        
       
        
        
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
        if levelTimerValue == 0 {
            gameOver()
        }
        if touchedNode == nil {
            return
        }
        if spot1.position.y < 77.110 || spot2.position.y < 77.110 || spot3.position.y < 77.110 || spot4.position.y < 77.110 {
            print("spot1:\(spot1.position.y)")
            print("spot1:\(spot2.position.y)")
            print("spot1:\(spot3.position.y)")
            print("spot1:\(spot4.position.y)")
            gameOver()
        }
        
        
        
    }
    
    func gameOver() {
    print("gameover!")
    state = .GameOver
    
beard1.runAction(SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.50))
        
sinceTouch+=fixedDelta
        
     let pointsLabel = childNodeWithName("pointsLabel") as! MLPointsLabel
     let highscoreLabel = childNodeWithName("highscoreLabel") as! MLPointsLabel
        
        if highscoreLabel.number < pointsLabel.number {
            highscoreLabel.setTo(pointsLabel.number)
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(highscoreLabel.number, forKey: "highscore")
            
        }
        
        
        
        
        
        
        
//    playButton.selectionHandler = {
//        let skView = self.view as SKView!
//    
//    
//        skView.presentScene(scene)
//    
//    }
}
    
    






}
