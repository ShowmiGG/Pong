//
//  MainMenuVC.swift
//  Pong
//
//  Created by Shumeng Guo on 09/11/2017.
//  Copyright © 2017 ShowmiCreations. All rights reserved.
//

import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
    
}

class MainMenuVC : UIViewController {
    
    @IBAction func btn2Player(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    
    @IBAction func btnEasy(_ sender: UIButton) {
        moveToGame(game: .easy)
    }
    
    @IBAction func btnMedium(_ sender: UIButton) {
        moveToGame(game: .medium)
    }
    
    @IBAction func btnHard(_ sender: UIButton) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
