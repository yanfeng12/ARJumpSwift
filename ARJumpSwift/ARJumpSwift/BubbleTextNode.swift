//
//  BubbleTextNode.swift
//  ARJumpSwift
//
//  Created by guopenglai on 2018/1/8.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit
import SceneKit

class BubbleTextNode: SCNNode {

    private let bubbleDepth : Float = 0.015 // the 'depth' of 3D text
    init(text : String, at position : SCNVector3) {
        super.init()
        //约束
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        // Lights
        let omniBackLight = SCNLight()
        omniBackLight.type = .omni
        omniBackLight.color = UIColor.white
        let omniBackLightNode = SCNNode()
        omniBackLightNode.light = omniBackLight
        omniBackLightNode.position = SCNVector3(position.x - 2, 0, position.z - 2)
        
        let omniFrontLight = SCNLight()
        omniFrontLight.type = .omni
        omniFrontLight.color = UIColor.white
        let omniFrontLightNode = SCNNode()
        omniFrontLightNode.light = omniFrontLight
        omniFrontLightNode.position = SCNVector3(position.x + 2, 0, position.z + 2)
        
        addChildNode(omniBackLightNode)
        addChildNode(omniFrontLightNode)
        
        // Text
        let bubble = SCNText(string: text, extrusionDepth: CGFloat(bubbleDepth / 5.0))
        bubble.font = UIFont(name: "HelveticaNeue", size: 0.18)
        bubble.alignmentMode = kCAAlignmentCenter
        bubble.firstMaterial?.diffuse.contents = UIColor.white
        bubble.firstMaterial?.specular.contents = UIColor.white
        bubble.firstMaterial?.isDoubleSided = false
        bubble.flatness = 0.01 // setting this too low can cause crashes.
        bubble.chamferRadius = 0.05
        
        //bubble
        /*
         SCNGeometry
         你可以从3D建模工具生成的.dae文件中加载一个几何体，也可以用代码创建，SceneKit 提供了几种常见几何体，是SCNGeometry 的子类，比如长方体，球，圆柱球等等，后面我们会写一个demo会把官方提供的几何体给大家列出来，给大家一个直观的感受。 当然我们也可以用三维坐标，法向量自定义几何体，也可以讲一个2D 图案转化成一个具有深度(厚度)的三维几何体。后面应该专门有一篇会讲到利用贝塞尔曲线将一个2D 图案转化成一个具有深度(厚度)的三维几何体。
         */
        let (minBound,maxBound) = bubble.boundingBox
        let bubbleNode = SCNNode(geometry: bubble)
        // Center Node - to Centre-Bottom point
        bubbleNode.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x) / 2, minBound.y, bubbleDepth / 2)
        // Reduce default text size
        bubbleNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        
        let backgroundBox = SCNBox(width: CGFloat((maxBound.x - minBound.x) / 4),
                                   height: 0.05,
                                   length: 0.02,
                                   chamferRadius: 0.01)
        backgroundBox.firstMaterial?.diffuse.contents = UIColor.lightGray
        backgroundBox.firstMaterial?.specular.contents = UIColor(white: 0.5, alpha: 0.80)
        backgroundBox.firstMaterial?.isDoubleSided = false
        
        // Box Node
        let backgroundNode = SCNNode(geometry: backgroundBox)
        bubbleNode.position = SCNVector3(0, -0.01, bubbleDepth)
        backgroundNode.addChildNode(bubbleNode)
        backgroundNode.name = "backgroundNode"
        
        addChildNode(backgroundNode)
        self.name = text
        //约束
        self.constraints = [billboardConstraint]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
