//
//  LaunchScreenController.swift
//  Places
//
//  Created by Victoriia Rohozhyna on 12/5/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import Foundation
import UIKit

class  LaunchScreenController: UIViewController {
    
    @IBOutlet weak var imageScreen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationLogo()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        sleep(1)
       
       
    }
    
    func animationLogo() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        self.present(vc!, animated: true, completion: nil)
        
    }
}
