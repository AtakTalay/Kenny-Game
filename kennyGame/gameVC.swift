//
//  gameVC.swift
//  kennyGame
//
//  Created by Ömer Ünlüsoy on 19.06.2020.
//  Copyright © 2020 Ömer Ünlüsoy. All rights reserved.
//

import UIKit

class gameVC: UIViewController {

    var gameSpeed: Double = 0.0
    var score: Int = 0
    var maxScore: Int = 0
    
    let pauseButton = UIButton()
    let timeLable = UILabel()
    let currentScoreLable = UILabel()
    let highScoreLable = UILabel()
    
    let kennyImage: UIImage = UIImage(named: "Kenny")!
    let imageViewKenny = UIImageView()
    var imageX: Int = 0
    var imageY: Int = 0
    
    var timer = Timer()         // You can use another timer for image
    var counter: Int = 0
    let TIME: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(gameSpeed)
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        // time Label
        timeLable.text = "Time"
        timeLable.font = UIFont(name: "Copperplate", size: 32)
        timeLable.textAlignment = .center
        timeLable.frame = CGRect(x: screenWidth * 0.4, y: screenHeight * 0.1, width: screenWidth * 0.2, height: screenWidth * 0.2)
        timeLable.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        timeLable.textColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        view.addSubview(timeLable)
        
        // currentScore Label
        currentScoreLable.text = "Score: \(score)"
        currentScoreLable.font = UIFont(name: "Copperplate", size: 12)
        currentScoreLable.textAlignment = .center
        currentScoreLable.frame = CGRect(x: screenWidth * 0.2, y: screenHeight * 0.15, width: screenWidth * 0.6, height: screenWidth * 0.2)
        currentScoreLable.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        currentScoreLable.textColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        view.addSubview(currentScoreLable)
        
        // highScore Label
        let maxScore1 = UserDefaults.standard.object(forKey: "maxScore") ?? 0
        highScoreLable.text = "Highscore: \(maxScore1)"
        highScoreLable.font = UIFont(name: "Copperplate", size: 12)
        highScoreLable.textAlignment = .center
        highScoreLable.frame = CGRect(x: screenWidth * 0.2, y: screenHeight * 0.85, width: screenWidth * 0.6, height: screenWidth * 0.2)
        highScoreLable.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        highScoreLable.textColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        view.addSubview(highScoreLable)
        
        // Pause Button
        pauseButton.setTitle("||", for: .normal)
        pauseButton.frame.size = CGSize(width: 35.0, height: 35.0)
        pauseButton.setTitleColor(UIColor.black, for: .normal)
        pauseButton.frame = CGRect(x: screenWidth * 0.88, y: screenHeight * 0.12, width: screenWidth * 0.05, height: screenHeight * 0.05)
        pauseButton.addTarget(self, action: #selector(self.pauseButtonPressed), for: .touchUpInside)
        view.addSubview(pauseButton)

        // Kenny Image
        imageViewKenny.contentMode = UIView.ContentMode.scaleAspectFit
        imageViewKenny.image = kennyImage
        view.addSubview(imageViewKenny)
        imageViewKenny.isUserInteractionEnabled = true
        
        // Timer
        counter = TIME
        timeLable.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1 - gameSpeed, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        let clickGesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        imageViewKenny.addGestureRecognizer(clickGesture)
    }
    
    @objc func timerFunc(){
        let screenWidth = view.frame.size.width
        
        timeLable.text = "\(counter)"
        
        counter -= 1
        decideImageLocation()
        imageViewKenny.frame = CGRect(x: imageX, y: imageY, width: Int(screenWidth * 0.27), height: Int(screenWidth * 0.27))
        if counter <= -1{
            timeIsOver()
        }
    }
    
    func timeIsOver(){
        timer.invalidate()
        if score > maxScore{
            maxScore = score
            UserDefaults.standard.set(maxScore, forKey: "maxScore")
        }
        let finishedAlert = UIAlertController(title: "Time is over", message: "", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.goBack() }
        let againButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.replay() }
        finishedAlert.addAction(okButton)
        finishedAlert.addAction(againButton)
        self.present(finishedAlert, animated: true, completion: nil)
    }
    
    @objc func imageClicked(){
        score += 1
        currentScoreLable.text = "Score: \(score)"
    }
    
    @objc func pauseButtonPressed(){
        timer.invalidate()
        let pauseAlert = UIAlertController(title: "Paused", message: "", preferredStyle: UIAlertController.Style.alert)
        let resumeButton = UIAlertAction(title: "Resume", style: UIAlertAction.Style.default){ (UIAlertAction) in
            self.timerFunc()
            self.timer = Timer.scheduledTimer(timeInterval: 1 - self.gameSpeed, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)}
        let goBackButton = UIAlertAction(title: "Start Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.goBack() }
        self.present(pauseAlert, animated: true, completion: nil)
        pauseAlert.addAction(resumeButton)
        pauseAlert.addAction(goBackButton)
    }
    
    func goBack(){
        performSegue(withIdentifier: "goBackSegue", sender: nil)
    }
    
    func replay(){
        score  = 0
        currentScoreLable.text = "Score: \(score)"
        counter = TIME
        timeLable.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1 - gameSpeed, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    
    func decideImageLocation(){
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height

        let locationArrayX: [Double] = [0.3, 0.45, 0.6]
        let locationArrayY: [Double] = [0.3, 0.45, 0.6]

        let randomX = Int.random(in: 0...2)         // Alternative: let random = Int(arc4random_uniform(UInt32(3)))
        let randomY = Int.random(in: 0...2)
        imageX = Int(Double(screenWidth) * locationArrayX[randomX])
        imageY = Int(Double(screenHeight) * locationArrayY[randomY])
    }
}

