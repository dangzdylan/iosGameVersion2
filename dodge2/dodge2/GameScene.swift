//
//  GameScene.swift
//  dodge2
//
//  Created by Dylan on 7/14/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//

import SpriteKit
import GameplayKit

/*
 **GOALS**
 
 - figure out how DIDBEGINCONTACT and contactbitmasking works √
 - organize objects; put in different files and make classes √
 - make monster spawn into playfield and bounce around at constant speed
 - animation placeholder for monster spawning in
 - fix coin moving random algorithm
 - fix up start and end screen
 - save highscore and put on end screen
 
 - SCORE BASED ON TIME NOT COINS, COINS USED FOR CURRENCY IN SHOP
 
 */

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .white
        self.physicsWorld.contactDelegate = self
        addBorders(self:self)
        addPlayer(self:self)
        addCoin(self: self)
        addScore(self: self)
        addSpawner(self: self)
        
        
        spawnMonster(self: self)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let speed = Player.size.width / 5
        if goingUp == true{
            if !goingRight{
                playerSpeed = CGVector(dx: speed, dy: speed)
            }else{
                playerSpeed = CGVector(dx: -speed, dy: speed)
            }
        }else{
            if !goingRight{
                playerSpeed = CGVector(dx: speed, dy: -speed)
            }else{
                playerSpeed = CGVector(dx: -speed, dy: -speed)
            }
        }
        goingRight = !goingRight
        
        
        Player.physicsBody?.velocity = CGVector(dx:0, dy:0)
        Player.physicsBody?.applyImpulse(playerSpeed)
    }
    

        
    
    override func update(_ currentTime: TimeInterval) {
        
        //player touching coin?
        if (isTouching(Player.position.x - coin.position.x, Player.position.y - coin.position.y, coin.size.width/1.9, Player.size.width/1.9)){
            
            touchCoin(self:self)
        }
         
    }
    
    
    func isTouching(_ c1:CGFloat , _ c2:CGFloat , _ r1:CGFloat , _ r2:CGFloat) -> Bool{
        let distance = sqrtf(Float(c1 * c1 + c2 * c2))
        
        return distance <= Float(r1 + r2)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        print(collision, contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask, ColliderType.Player | ColliderType.Monster)
        //change direction of player
        if collision == ColliderType.Player | ColliderType.topBorder || collision == ColliderType.Player | ColliderType.bottomBorder{
            goingUp = !goingUp
        }
        
        //monster vs borders
        
        //player vs monster
        if collision == ColliderType.Player | ColliderType.Monster{
            gameOver()
        }
        
        
        
    }


    func gameOver(){
        scoreNum = 0
        score.text = String(scoreNum)
        removeAllChildren()
        let temp = GameOverScene(fileNamed: "GameOverScene")
        self.scene?.view?.presentScene(temp!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
        
    }
    
}



