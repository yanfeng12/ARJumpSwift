//
//  UIViewControllerExtension.swift
//  ARJumpSwift
//
//  Created by guopenglai on 2018/1/8.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
