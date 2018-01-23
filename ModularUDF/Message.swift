//
//  Message.swift
//  ModularUDF
//
//  Created by Alex Ramey on 1/22/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct Message {
    static var counter: Int = 1
    var msg: String = ""
    var id: Int
    
    let alphabet: [String] = ["🍩", "👻", "🐘", "🙃", "💰", "🎉", "🤦‍♂️", "😍"]
    
    init(){
        self.id = Message.counter
        Message.counter += 1
        
        self.msg = generateRandomMessage()
    }
    
    func generateRandomMessage() -> String {
        var result = ""
        let numLetters = UInt32(alphabet.count)
        for _ in 1...10 {
            let rnd = Int(arc4random_uniform(numLetters))
            result += alphabet[rnd]
        }
        return result
    }
}
