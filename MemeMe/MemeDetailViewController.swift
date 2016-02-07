//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Gareth Hunt on 7/02/2016.
//  Copyright © 2016 ghunt03. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
        
    }
}