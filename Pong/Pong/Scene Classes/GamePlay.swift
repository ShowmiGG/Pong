//
//  GamePlay.swift
//  Pong
//
//  Created by Shumeng Guo on 09/11/2017.
//  Copyright © 2017 ShowmiCreations. All rights reserved.
//

import Foundation
import SpriteKit

class GamePlay : SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player = SKSpriteNode()
    var score = [0,0]
    var topLabel = SKLabelNode()
    var botLablel = SKLabelNode()
    
    override func didMove(to view: SKView) {

        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height/2) - 50
        player = self.childNode(withName: "player") as! SKSpriteNode
        player.position.y = (-self.frame.height/2) + 50
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        botLablel = self.childNode(withName: "botLabel") as! SKLabelNode
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 12.5)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.linearDamping = 0
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        
    }
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        botLablel.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    func addScore(playerWhoWon:SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                  player.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
            case .easy :
                enemy.run(SKAction.moveTo(x: ball.position.x , duration: 0.5))
                break
            case .medium :
                enemy.run(SKAction.moveTo(x: ball.position.x , duration: 0.3))
                break
            case .hard :
                enemy.run(SKAction.moveTo(x: ball.position.x , duration: 0.1))
                break
            case .player2 :
                break
        }
        
        if ball.position.y <= player.position.y - 30 {
            addScore(playerWhoWon: enemy)
            topLabel.text = "\(score[1])"
            botLablel.text = "\(score[0])"
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: player)
            topLabel.text = "\(score[1])"
            botLablel.text = "\(score[0])"
        }
    }
}






















