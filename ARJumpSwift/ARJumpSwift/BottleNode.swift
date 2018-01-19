//
//  BottleNode.swift
//  ARJumpSwift
//
//  Created by guopenglai on 2018/1/8.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit
import SceneKit

class BottleNode: SCNNode {

    private let minimunHeight :CGFloat = 0.15
    private let durationToReduce :TimeInterval = 1.0 / 600.0
    private let coneNodeHeight          : CGFloat = 0.2
    private let reduceHeightUnit        : CGFloat = 0.001
    
    //swift 懒加载
    lazy var myMaterial :SCNMaterial = {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.randomColor()
        return material
    }()
    //球体节点
    lazy var sphereNode :SCNNode = {
       let sphere = SCNSphere(radius: 0.02)
        sphere.materials = [myMaterial]
        return SCNNode(geometry: sphere)
    }()
    //锥体节点
    lazy var coneNode: SCNNode = {
        let cone = SCNCone(topRadius: 0.0, bottomRadius: 0.05, height: coneNodeHeight)
        cone.materials = [myMaterial]
        return SCNNode(geometry: cone)
    }()
    
    override init() {
        super.init()
        sphereNode.position = SCNVector3(0, coneNodeHeight / 2.0, 0)
        coneNode.addChildNode(sphereNode)
        addChildNode(coneNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scaleHeight()  {
        //SCNCone *aconeNode = (SCNCone *)_coneNode.geometry;
        //as! 向下转型（Downcasting）时使用。由于是强制类型转换，如果转换失败会报 runtime 运行错误。
        let coneGeometry = coneNode.geometry as! SCNCone
        if coneGeometry.height > minimunHeight{
            //SceneKit 框架有自己的动画API,也可以用CABasicAnimation
            sphereNode.runAction(SCNAction.move(by: SCNVector3(0, -reduceHeightUnit, 0), duration: durationToReduce))
            coneNode.runAction(SCNAction.run({ (_) in
                coneGeometry.height -= self.reduceHeightUnit
            }))
            
        }
    }
    
    func recover()  {
        sphereNode.position = SCNVector3(0, coneNodeHeight / 2.0, 0)
        (coneNode.geometry as! SCNCone).height = coneNodeHeight
    }
    
}
