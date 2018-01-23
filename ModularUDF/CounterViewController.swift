//
//  ViewController.swift
//  ModularUDF
//
//  Created by Alex Ramey on 1/22/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {
    @IBOutlet weak var count: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        (self.tabBarController as? TabBarController)?.store.addDelegate(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CounterViewController: MessageStoreDelegate {
    func messageStore(_ messageStore: MessageStore, hasNewState state: [[Message]]) {
        self.count.text = "Unread: \(state[0].count)"
    }
}


