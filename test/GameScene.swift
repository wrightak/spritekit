//
//  GameScene.swift
//  test
//
//  Created by Pivotal on 3/27/18.
//  Copyright © 2018 Pivotal. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var numberNodes : [SKShapeNode]?
    
    override func didMove(to view: SKView) {
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)
        
        let circleDiameter: CGFloat = 80.0
        let circleRadius: CGFloat = circleDiameter / 2.0
        let spacing: CGFloat = 20.0
        let horizontalNodeCount: Int = Int(floor((self.size.width - spacing) / (circleDiameter + spacing)))
        let verticalNodeCount: Int = 10
        
        var nodes: [SKShapeNode] = []
        
        for x in 0..<horizontalNodeCount {
            for y in 0..<verticalNodeCount {
                let node = SKShapeNode(circleOfRadius: circleDiameter / 2.0)
                var xPosition: CGFloat
                var yPosition: CGFloat
                if x == 0 {
                    xPosition = spacing + circleRadius
                } else {
                    xPosition = spacing + circleRadius + (CGFloat(x) * (circleDiameter + spacing))
                }
                
                if y == 0 {
                    yPosition = self.size.height - (spacing + circleRadius)
                } else {
                    yPosition = self.size.height - (spacing + circleRadius + (CGFloat(y) * (circleDiameter + spacing)))
                }
                
                node.position = CGPoint(x: xPosition, y: yPosition)
                node.fillColor = SKColor.clear
                node.strokeColor = SKColor.white
                nodes.append(node)
                self.addChild(node)
            }
        }
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        guard let numberNodes = numberNodes else {
            return
        }
        
        
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
