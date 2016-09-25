//
//  Character.swift
//  Zeldre Returns
//
//  Created by Greg Willis on 9/23/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int = 100
    private var _attackPwr: Int = 0
    
    var attackPwr: Int {
        get {
            return _attackPwr
        }
        set {
            self._attackPwr = calculateAttPwr()
        }
    }
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    
    var isAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    init(startingHp: Int, attackPwr: Int) {
        self._hp = startingHp
        self.attackPwr = attackPwr
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        guard attackPwr > 0 else {
            return false
        }
        self._hp -= attackPwr
        
        return true
    }
    
    func calculateAttPwr() -> Int {
        let random = Int(arc4random_uniform(5) * 5)
        print("I picked \(random) BITCH!")
        self._attackPwr = random
        return random
    }
    
    func reset() {
        self._hp = 100
    }
}
