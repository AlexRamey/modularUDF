//
//  TabBarController.swift
//  ModularUDF
//
//  Created by Alex Ramey on 1/22/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let store: MessageStore = MessageStore(service: MessageService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
