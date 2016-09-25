//
//  ViewController.swift
//  Zeldre Returns
//
//  Created by Greg Willis on 9/21/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var enemyImg: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    
    var player1: Player!
    var player2: Player!
    var buttonSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1 = Player(name: "Bob", hp: 100, attackPwr: 0)
        player2 = Player(name: "Harry", hp: 100, attackPwr: 0)
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
            buttonSound.volume = 0.5
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        loadGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func player1AttBtnPressed(sender: AnyObject) {
        if player1.attemptAttack(player1.calculateAttPwr()) {
            textLbl.text = "Attacked " + player2.name + " for " + String(player1.attackPwr) + " HP!"
//            textLbl.text = "Attacked \(player2.name) for \(player1.attackPwr) HP!"
        } else {
            textLbl.text = "Attack has failed"
        }
        playSound()
        checkGameOver()
    }

    @IBAction func player2AttBtnPressed(sender: AnyObject) {
        if player2.attemptAttack(player2.calculateAttPwr()) {
            textLbl.text = "Attacked \(player1.name) for \(player2.attackPwr) HP!"
        } else {
            textLbl.text = "Attack has failed"
        }
        playSound()
        checkGameOver()
    }
    
    @IBAction func restartBtnPressed(sender: AnyObject) {
        playSound()
        loadGame()
    }
    
    // MARK: - Helper Functions
    
    func checkGameOver() {
        var showReset = false
        
        if !player1.isAlive {
            playerImg.hidden = true
            textLbl.text = "\(player2.name) has won!"
            showReset = true
        }
        
        if !player2.isAlive {
            enemyImg.hidden = true
            textLbl.text = "\(player1.name) has won!"
            showReset = true
        }
        
        guard showReset else {
            return
        }
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(showRestartButton), userInfo: nil, repeats: false)
    }
    
    func loadGame() {
        playerImg.hidden = false
        enemyImg.hidden = false
        restartBtn.hidden = true
        textLbl.text = "Protect the homeland!"
        player1.reset()
        player2.reset()
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func showRestartButton() {
        restartBtn.hidden = false
    }
    
}

