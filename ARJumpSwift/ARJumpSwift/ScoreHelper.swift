//
//  ScoreHelper.swift
//  ARJumpSwift
//
//  Created by guopenglai on 2018/1/8.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit

class ScoreHelper: NSObject {

    override init() {
        
    }
    static let shared: ScoreHelper = ScoreHelper()
    
    func getHighestScore() -> Int {
        return UserDefaults.standard.integer(forKey: "highest_score")
    }
    func setHighestScore(score:Int)  {
        if score > getHighestScore(){
            UserDefaults.standard.set(score, forKey: "highest_score")
            UserDefaults.standard.synchronize()
        }
    }
}
