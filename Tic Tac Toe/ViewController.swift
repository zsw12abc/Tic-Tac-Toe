//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Shaowei Zhang on 15/7/18.
//  Copyright © 2015年 Shaowei Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 1 = nought, 2 = crosses, 0 = nothing
    var activePlayer = 1
    var gameActive = true
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func newGamePressed(sender: AnyObject) {
        gameActive = true
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        var button : UIButton
        for var i = 1; i < 10; i++ {
            //会出现 crash(Could not cast value of type 'UIView' (0x1111277d8) to 'UIButton' (0x11112def8).) 的原因是所有元素的默认 tag 都是0 
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, forState: .Normal)
        }
        message.alpha = 0
    }
    
    override func viewDidLayoutSubviews() {
        message.alpha = 0
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var image = UIImage()
        
        if gameState[sender.tag - 1] == 0 && gameActive == true {
            
            gameState[sender.tag - 1] = activePlayer
            
            if activePlayer == 1 {
                image = UIImage(named: "cross.png")!
                activePlayer = 2
            } else {
                image = UIImage(named: "nought.png")!
                activePlayer = 1
            }
            
            sender.setImage(image, forState: .Normal)
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]] {
                if gameState[combination[0]] == 1 {
                    message.text = "cross won"
                }else{
                    message.text = "nought won"
                }
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.message.alpha = 1
                })
                gameActive = false
            }
        }
    }
}

