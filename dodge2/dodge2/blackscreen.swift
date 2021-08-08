//
//  blackscreen.swift
//  dodge2
//
//  Created by Dylan on 8/6/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//


import SpriteKit
import GameplayKit


//FIX CENTERING PROBLEM
class BlackScreen:SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let temp = GameScene(fileNamed: "GameScene")
        self.scene?.view?.presentScene(temp!, transition:SKTransition.fade(withDuration: 1))
    }
}
