//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Bhumika Hirapara on 2/17/22.
//

import UIKit

class ViewController: UIViewController {
    
//    Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
//    Variables
    var kennyArray = [UIImageView]()
    var countDowntimer = Timer()
    var hideKennyTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let kenny1Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny1.addGestureRecognizer(kenny1Gesture)
        let kenny2Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny2.addGestureRecognizer(kenny2Gesture)
        let kenny3Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny3.addGestureRecognizer(kenny3Gesture)
        let kenny4Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny4.addGestureRecognizer(kenny4Gesture)
        let kenny5Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny5.addGestureRecognizer(kenny5Gesture)
        let kenny6Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny6.addGestureRecognizer(kenny6Gesture)
        let kenny7Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny7.addGestureRecognizer(kenny7Gesture)
        let kenny8Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny8.addGestureRecognizer(kenny8Gesture)
        let kenny9Gesture = UITapGestureRecognizer(target: self, action: #selector(increaseScoreGesture))
        kenny9.addGestureRecognizer(kenny9Gesture)
        
        timerStarts()
    }
    
    func timerStarts() {
        counter = 10
        timeLabel.text = "Time: \(counter)"
        score = 0
        scoreLabel.text = "Score: \(score)"
        
        countDowntimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimerFired), userInfo: nil, repeats: true)
        
        hideKennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        let storedHighScore = defaults.object(forKey: "HighScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newStoredHighScore = storedHighScore as? Int {    // to check if this value exists or not
            highScore = newStoredHighScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
    }
    
    @objc func hideKenny() {
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
//        let randomKennyImage = kennyArray.randomElement()
//        randomKennyImage?.isHidden = false
        
        let randomKennyImage = kennyArray[Int.random(in: 0...8)]
        randomKennyImage.isHidden = false
        
//        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
//        print(random)
//        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScoreGesture() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func countDownTimerFired() {
        
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        if counter == 0 {
            
            countDowntimer.invalidate()
            hideKennyTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "HighScore: \(highScore)"
                defaults.set(highScore, forKey: "HighScore")        // UserDefaults
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okButton)
            
            let replayButton = UIAlertAction(title: "Replay", style: .default) { action in
                
                self.timerStarts()
            }
            alert.addAction(replayButton)
            
            present(alert, animated: true, completion: nil)
            
        }
    }
}

