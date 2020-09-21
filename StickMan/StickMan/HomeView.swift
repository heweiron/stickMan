//
//  HomeView.swift
//  StickMan
//
//  Created by weirong he on 9/20/20.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }
    @State var test = false
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
        }
    }
}


class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player")
    var playerAnimationArray = [SKTexture(imageNamed: "player")]
    var playerSpeed: CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        
        //MARK: - background init
        let background = SKSpriteNode(color: .white, size: CGSize(width: UIScreen.main.bounds.width + 200, height: UIScreen.main.bounds.height))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        
        
        let ground = SKSpriteNode(color: UIColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/10))
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.size.width, height: ground.size.height))
        ground.physicsBody?.isDynamic = false
        ground.position.x = frame.midX
        ground.position.y = frame.minY + ground.size.height
        addChild(ground)
        
        // MARK: - 操作方向按钮
        let runLeftButton = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        runLeftButton.name = "runLeftButton"
        runLeftButton.position.x = frame.minX + 100
        runLeftButton.position.y = frame.maxY - 100
        addChild(runLeftButton)
        
        
        let runRightButton = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        runRightButton.name = "runRightButton"
        runRightButton.position.x = frame.minX + 200
        runRightButton.position.y = frame.maxY - 100
        addChild(runRightButton)
        
        
        // MARK: - Player init
        player.name = "player"
        player.position.x = frame.midX
        player.position.y = frame.minY + 400
        player.zPosition = 1
        
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: player.size.height))
        player.physicsBody?.allowsRotation = false

        
        //physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 0), to: CGPoint(x: UIScreen.main.bounds.maxX, y: 0))
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.position.x = player.position.x + playerSpeed * 10
        if player.position.x > frame.maxX {
            player.position.x = frame.maxX
        }
        if player.position.x <= frame.minX {
            player.position.x = frame.minX
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "runRightButton" {
                // Call the function here.
                
                playerSpeed = 1
                runRight()
                
            }
            if touchedNode.name == "runLeftButton" {
                // Call the function here.
                
                playerSpeed = -1
                runRight()
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            stopRun()
            playerSpeed = 0
            if touchedNode.name == "runRightButton" {
                // Call the function here.
                stopRun()
            }
        }
    }
    
    
    
    // MARK: -Control Player Functions
    
    func playerRightRun() {
        
        playerAnimationArray = [
            //SKTexture(imageNamed: "player24"),
            //SKTexture(imageNamed: "player02"),
            SKTexture(imageNamed: "player03"),
            SKTexture(imageNamed: "player04"),
            SKTexture(imageNamed: "player05"),
            SKTexture(imageNamed: "player06"),
            SKTexture(imageNamed: "player07"),
            SKTexture(imageNamed: "player08"),
            SKTexture(imageNamed: "player10"),
            SKTexture(imageNamed: "player11"),
            //SKTexture(imageNamed: "player12"),
            SKTexture(imageNamed: "player13"),
            //SKTexture(imageNamed: "player15"),
            SKTexture(imageNamed: "player16"),
            SKTexture(imageNamed: "player18"),
            SKTexture(imageNamed: "player19"),
            SKTexture(imageNamed: "player20"),
            SKTexture(imageNamed: "player22"),
            SKTexture(imageNamed: "player23"),
        ]
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.03)
        let playerAnimateForever = SKAction.repeatForever(playerAnimate)
        
        let movePlayer = SKAction.moveBy(x: player.size.width*1.7, y: 0, duration: 3)
        player.run(SKAction.sequence([playerAnimateForever,movePlayer, SKAction.removeFromParent()]),withKey:"playerRun")
        
        //        let moveAndRemoveSequence = SKAction.sequence([movePlayer, SKAction.removeFromParent()])
        //        let wholeAction = SKAction.group([playerAnimateForever, moveAndRemoveSequence])
        //        player.run(wholeAction, withKey: "playerRun")
    }
    
    func playerLeftRun() {
        playerAnimationArray = [
            //SKTexture(imageNamed: "lplayer24"),
            //SKTexture(imageNamed: "lplayer02"),
            SKTexture(imageNamed: "lplayer03"),
            SKTexture(imageNamed: "lplayer04"),
            SKTexture(imageNamed: "lplayer05"),
            SKTexture(imageNamed: "lplayer06"),
            SKTexture(imageNamed: "lplayer07"),
            SKTexture(imageNamed: "lplayer08"),
            SKTexture(imageNamed: "lplayer10"),
            SKTexture(imageNamed: "lplayer11"),
            //SKTexture(imageNamed: "lplayer12"),
            SKTexture(imageNamed: "lplayer13"),
            //SKTexture(imageNamed: "lplayer15"),
            SKTexture(imageNamed: "lplayer16"),
            SKTexture(imageNamed: "lplayer18"),
            SKTexture(imageNamed: "lplayer19"),
            //SKTexture(imageNamed: "lplayer20"),
            SKTexture(imageNamed: "lplayer22"),
            SKTexture(imageNamed: "lplayer23"),
        ]
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.03)
        let playerAnimateForever = SKAction.repeatForever(playerAnimate)
        
        let movePlayer = SKAction.moveBy(x: player.size.width*1.7, y: 0, duration: 3)
        player.run(SKAction.sequence([playerAnimateForever,movePlayer, SKAction.removeFromParent()]),withKey:"playerRun")
    }
    
    
    func runRight() {
        //        player.position.x = frame.minX + 200
        //        player.position.y = frame.minY + 400
        //        player.zPosition = 1
        if playerSpeed > 0 {
            playerRightRun()
        } else if playerSpeed < 0 {
            playerLeftRun()
        }
    }
    
    func stopRun() {
        player.removeAction(forKey: "playerRun")
        if playerSpeed > 0 {
            player.texture = SKTexture(imageNamed: "player")
        } else if playerSpeed < 0 {
            player.texture = SKTexture(imageNamed: "lplayer")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}