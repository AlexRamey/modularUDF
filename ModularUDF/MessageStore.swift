//
//  MessageStore.swift
//  ModularUDF
//
//  Created by Alex Ramey on 1/22/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

class MessageStore: MessageServiceDelegate {
    private var messageService: MessageService
    private var delegates: [MessageStoreDelegate] = []
    private var unreadMessages: [Message] = []
    private var readMessages: [Message] = []
    
    init(service: MessageService) {
        self.messageService = service
        self.messageService.addDelegate(self)
    }
    
    func addDelegate(_ delegate: MessageStoreDelegate) {
        self.delegates.append(delegate)
    }
    
    func markMessageAsRead(msg: Message) {
        if !self.readMessages.contains(where: { (candidate) -> Bool in
            candidate.id == msg.id
        }){
            self.readMessages.append(msg)
        }
        
        if let idx = self.unreadMessages.index(where: { (candidate) -> Bool in
            candidate.id == msg.id
        }){
            self.unreadMessages.remove(at: idx)
        }
        
        self.notify()
    }
    
    func notify(){
        self.delegates.forEach { (delegate) in
            delegate.messageStore(self, hasNewState: [unreadMessages, readMessages])
        }
    }
    
    // MARK - MessageServiceDelegate
    func messageService(_ messageService: MessageService, didReceiveMessage msg: Message) {
        print(msg.msg)
        self.unreadMessages.append(msg)
        self.notify()
    }
}

protocol MessageStoreDelegate {
    func messageStore(_ messageStore: MessageStore, hasNewState state: [[Message]])
}
