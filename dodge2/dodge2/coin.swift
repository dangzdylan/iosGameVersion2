//
//  coin.swift
//  dodge2
//
//  Created by Dylan on 8/2/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//

import SpriteKit
import GameplayKit




func addCoin(self:GameScene){
    let radius = screenWidth/30
    coin = SKSpriteNode(color: .yellow, size: CGSize(width: screenWidth/30, height: screenWidth/30))
    
    coin.texture = SKTexture(imageNamed: "coin")
    
    coin.position = CGPoint(x: screenWidth/7, y: screenWidth/7)
    coin.zPosition = 0
    
    //coin physics
    coin.physicsBody = SKPhysicsBody(circleOfRadius: radius / 2)
    coin.physicsBody?.categoryBitMask = ColliderType.coin
    coin.physicsBody?.contactTestBitMask = ColliderType.coin
    coin.physicsBody?.collisionBitMask = ColliderType.coin
    coin.physicsBody?.isDynamic = false
    coin.physicsBody?.affectedByGravity = false
    
    self.addChild(coin)
}

func touchCoin(self:GameScene){
    //update score
    scoreNum += 1
    if scoreNum % 10 == 0{
        spawnMonster(self: self)
    }
    score.text = String(scoreNum)
    
    //move coin to new position
    let distanceW = CGFloat(Player.size.width)
    let distanceH = CGFloat(Player.size.height)
    let coinCoord = [CGFloat.random(in: -xPointBorder + distanceW...xPointBorder - distanceW), CGFloat.random(in: -yPointBorder + distanceH...yPointBorder - distanceH)]
    coin.run(SKAction.move(to: CGPoint(x: coinCoord[0], y: coinCoord[1]), duration: 0))
    
    
}
