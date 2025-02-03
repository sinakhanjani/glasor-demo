//
//  CustomSideMenuController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit
import SideMenuController

class CustomSideMenuController: SideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }
    
    // Method
    func updateUI() {
        performSegue(withIdentifier: LOADER_TO_MAIN_SEGUE, sender: nil)
        performSegue(withIdentifier: CONTENT_SIDE_MENU_SEGUE, sender: nil)
    }
    
    
}

