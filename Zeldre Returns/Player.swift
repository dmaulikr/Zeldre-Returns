//
//  PlayerOne.swift
//  Zeldre Returns
//
//  Created by Greg Willis on 9/23/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Foundation

class Player: Character {
    
    private(set) var name = "Player"
    private(set) var inventory = [String]()
    
    convenience init(name: String, hp: Int, attackPwr: Int) {
        self.init(startingHp: hp, attackPwr: attackPwr)
        self.name = name
    }
    
    func addItemToInventory(item: String) {
        inventory.append(item)
    }
}