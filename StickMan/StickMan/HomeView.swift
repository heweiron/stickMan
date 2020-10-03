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
    
    let player = SKSpriteNode(imageNamed: "火柴人")
    var playerAnimationArray = [SKTexture(imageNamed: "火柴人")]
    var playerSpeed: CGFloat = 0
    var playerFaceRight = true

    
    override func didMove(to view: SKView) {
        
        
        //MARK: - background init
        let background = SKSpriteNode(color: .white, size: CGSize(width: UIScreen.main.bounds.width + 200, height: UIScreen.main.bounds.height))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        
        
        let ground = SKSpriteNode(color: UIColor(Color(#colorLiteral(red: 0.4388668537, green: 0.8085464239, blue: 0.2202020884, alpha: 0.7059342894))), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/10))
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.size.width, height: ground.size.height))
        ground.physicsBody?.isDynamic = false
        ground.position.x = frame.midX
        ground.position.y = frame.minY + ground.size.height
        addChild(ground)
        
        // MARK: - 操作方向按钮
        let runLeftButton = SKSpriteNode(imageNamed: "leftArrow")
        
        runLeftButton.name = "runLeftButton"
        runLeftButton.position.x = frame.minX + 50
        runLeftButton.position.y = frame.minY + 100
        addChild(runLeftButton)
        
        
        let runRightButton = SKSpriteNode(imageNamed: "rightArrow")
        runRightButton.name = "runRightButton"
        runRightButton.position.x = frame.minX + 150
        runRightButton.position.y = frame.minY + 100
        addChild(runRightButton)
        
        // MARK: - 动作按钮
        let punchButton = SKSpriteNode(color: .black, size: CGSize(width: 50, height: 50))
        punchButton.name = "punchButton"
        punchButton.position.x = frame.minX + 300
        punchButton.position.y = frame.minY + 120
        addChild(punchButton)
        
        let jumpButton = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        jumpButton.name = "jumpButton"
        jumpButton.position.x = frame.minX + 360
        jumpButton.position.y = frame.minY + 120
        addChild(jumpButton)
        
        
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
        
        // MARK: -player movement
        // if player is not jump
        if player.position.y <= frame.minY + UIScreen.main.bounds.height/10 + player.size.height/2 + 45.1 {
            player.position.x = player.position.x + playerSpeed * 10
        } else { // player is jumped
            player.position.x = player.position.x + playerSpeed * 6
        }
        if player.position.x > frame.maxX {
            player.position.x = frame.maxX
        }
        if player.position.x <= frame.minX {
            player.position.x = frame.minX
        }
        
    }
    
    
    // MARK:- Button handler
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "runRightButton" {
                // Call the function here.
                
                playerSpeed = 1
                run()
                
            }
            if touchedNode.name == "runLeftButton" {
                // Call the function here.
                
                playerSpeed = -1
                run()
                
            }
            if touchedNode.name == "punchButton" {
                // Call the function here.
                punch()
                
            }
            
            if touchedNode.name == "jumpButton" {
                // Call the function here.
                jump()
                
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
    
    // MARK: -Animation Functions
    // MARK: -跑步动画
    func playerRightRun() {
        if player.position.y <= frame.minY + UIScreen.main.bounds.height/10 + player.size.height/2 + 45.1 {
            playerAnimationArray = [
                SKTexture(imageNamed: "火柴人跑01"),
                SKTexture(imageNamed: "火柴人跑02"),
                SKTexture(imageNamed: "火柴人跑03"),
                SKTexture(imageNamed: "火柴人跑04"),
                SKTexture(imageNamed: "火柴人跑05"),
                SKTexture(imageNamed: "火柴人跑04"),
                SKTexture(imageNamed: "火柴人跑03"),
                SKTexture(imageNamed: "火柴人跑02"),
                SKTexture(imageNamed: "火柴人跑01"),
            ]
        } else {
            playerAnimationArray = [
                SKTexture(imageNamed: "火柴人"),
            ]
        }
        let movePlayer = SKAction.moveBy(x: player.size.width*1.7, y: 0, duration: 3)
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.1)
        let playerAnimateForever = SKAction.repeatForever(playerAnimate)
        
        
        player.run(SKAction.sequence([playerAnimateForever,movePlayer, SKAction.removeFromParent()]),withKey:"playerRun")
        
        //        let moveAndRemoveSequence = SKAction.sequence([movePlayer, SKAction.removeFromParent()])
        //        let wholeAction = SKAction.group([playerAnimateForever, moveAndRemoveSequence])
        //        player.run(wholeAction, withKey: "playerRun")
    }

    func playerLeftRun() {
        
        if player.position.y <= frame.minY + UIScreen.main.bounds.height/10 + player.size.height/2 + 45.1 {
        playerAnimationArray = [
            SKTexture(imageNamed: "火柴人跑左01"),
            SKTexture(imageNamed: "火柴人跑左02"),
            SKTexture(imageNamed: "火柴人跑左03"),
            SKTexture(imageNamed: "火柴人跑左04"),
            SKTexture(imageNamed: "火柴人跑左05"),
            SKTexture(imageNamed: "火柴人跑左04"),
            SKTexture(imageNamed: "火柴人跑左03"),
            SKTexture(imageNamed: "火柴人跑左02"),
            SKTexture(imageNamed: "火柴人跑左01"),
        ]
        } else {
            playerAnimationArray = [
                SKTexture(imageNamed: "火柴人左"),
            ]
        }
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.1)
        let playerAnimateForever = SKAction.repeatForever(playerAnimate)
        
        let movePlayer = SKAction.moveBy(x: player.size.width*1.7, y: 0, duration: 3)
        player.run(SKAction.sequence([playerAnimateForever,movePlayer, SKAction.removeFromParent()]),withKey:"playerRun")
    }
    
    // MARK: -攻击动画
    func playerRightPunch() {

        playerAnimationArray = [
            SKTexture(imageNamed: "火柴人01"),
            SKTexture(imageNamed: "火柴人02"),
            SKTexture(imageNamed: "火柴人03"),
            SKTexture(imageNamed: "火柴人04"),
            SKTexture(imageNamed: "火柴人05"),
            SKTexture(imageNamed: "火柴人"),

        ]
        
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.1)
        player.run(playerAnimate, withKey: "playerPunch")
    }
    
    func playerLeftPunch() {

        playerAnimationArray = [
            SKTexture(imageNamed: "火柴人左01"),
            SKTexture(imageNamed: "火柴人左02"),
            SKTexture(imageNamed: "火柴人左03"),
            SKTexture(imageNamed: "火柴人左04"),
            SKTexture(imageNamed: "火柴人左05"),
            SKTexture(imageNamed: "火柴人左"),

        ]
        
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.1)
        player.run(playerAnimate, withKey: "playerLeftPunch")
    }
    
    
    // MARK: -跳跃动画
    func playerRightJump() {

        playerAnimationArray = [
            SKTexture(imageNamed: "火柴人跳01"),
            SKTexture(imageNamed: "火柴人跳02"),
            SKTexture(imageNamed: "火柴人跳03"),
            SKTexture(imageNamed: "火柴人跳04"),
            SKTexture(imageNamed: "火柴人"),
        ]
        
        
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.1)
        let movePlayer = SKAction.moveBy(x: 0, y: player.size.height*1.6, duration: 0.8)
        player.run(SKAction.sequence([playerAnimate,movePlayer]),withKey:"playerRightJump")

    }
    
    func playerLeftJump() {

        playerAnimationArray = [
            SKTexture(imageNamed: "火柴人跳左01"),
            SKTexture(imageNamed: "火柴人跳左02"),
            SKTexture(imageNamed: "火柴人跳左03"),
            SKTexture(imageNamed: "火柴人跳左04"),
            SKTexture(imageNamed: "火柴人左"),
        ]
        
        
        let playerAnimate = SKAction.animate(with: playerAnimationArray, timePerFrame: 0.1)
        let movePlayer = SKAction.moveBy(x: 0, y: player.size.height*1.6, duration: 0.8)
        player.run(SKAction.sequence([playerAnimate,movePlayer]),withKey:"playerLeftJump")

    }
    
    // MARK:- player control functions
    func run() {
        if playerSpeed > 0 {
            playerRightRun()
        } else if playerSpeed < 0 {
            playerLeftRun()
        }
    }
    
    func stopRun() {
        player.removeAction(forKey: "playerRun")
        if playerSpeed > 0 {
            player.texture = SKTexture(imageNamed: "火柴人")
            playerFaceRight = true
        } else if playerSpeed < 0 {
            player.texture = SKTexture(imageNamed: "火柴人左")
            playerFaceRight = false
        }
    }
    
    func punch() {
        if playerFaceRight {
            playerRightPunch()
        } else {
            playerLeftPunch()
        }
    }
    
    func jump() {
        if playerFaceRight {
            playerRightJump()
        } else {
            playerLeftJump()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
