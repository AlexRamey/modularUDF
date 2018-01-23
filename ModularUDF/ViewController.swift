//
//  ViewController.swift
//  ModularUDF
//
//  Created by Alex Ramey on 1/22/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var store: MessageStore? = nil
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier: String = "reuseIdentifier"
    var messages: [Message] = []
    var unreadIDs: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.store = (self.tabBarController as? TabBarController)?.store
        self.store?.addDelegate(self)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = self.tabBarController!.selectedIndex == 0 ? "Chat Tab" : "Messages"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: MessageStoreDelegate {
    func messageStore(_ messageStore: MessageStore, hasNewState state: [[Message]]) {
        unreadIDs = state[0].map({ (unreadMsg) -> Int in
            return unreadMsg.id
        })
        
        self.messages = (state[0] + state[1]).sorted(by: { (msg1, msg2) -> Bool in
            return msg1.id < msg2.id
        })
        
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.textLabel?.text = self.messages[indexPath.row].msg
        
        if unreadIDs.contains(where: { (id) -> Bool in
            return id == self.messages[indexPath.row].id
        }){
            cell?.backgroundColor = UIColor.cyan
        } else {
            cell?.backgroundColor = UIColor.white
        }
        
        return cell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.store?.markMessageAsRead(msg: self.messages[indexPath.row])
    }
}


