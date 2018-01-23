//
//  MessageService.swift
//  ModularUDF
//
//  Created by Alex Ramey on 1/22/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

class MessageService {
    private var delegates: [MessageServiceDelegate] = []
    
    func addDelegate(_ delegate: MessageServiceDelegate) {
        self.delegates.append(delegate)
    }
    
    init(){
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { (_) in
            let msg = Message()
            self.delegates.forEach({ (delegate) in
                delegate.messageService(self, didReceiveMessage: msg)
            })
        })
    }
}

protocol MessageServiceDelegate  {
    func messageService(_ messageService: MessageService, didReceiveMessage msg: Message)
}
