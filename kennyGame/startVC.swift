//
//  startVC.swift
//  kennyGame
//
//  Created by Ömer Ünlüsoy on 19.06.2020.
//  Copyright © 2020 Ömer Ünlüsoy. All rights reserved.
//

import UIKit

class startVC: UIViewController {

    let gameNameLabel = UILabel()
    var speedLabel = UILabel()
    let startButton = UIButton()
    var speed : Double = 0.0
    let contributionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        // Game Name Label
        contributionLabel.numberOfLines = 0
        contributionLabel.text = "coded by Ömer Ünlüsoy"
        contributionLabel.font = UIFont(name: "Copperplate", size: 12)
        contributionLabel.textAlignment = .center
        contributionLabel.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.8, width: screenWidth * 0.8, height: screenHeight * 0.2)
        contributionLabel.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        contributionLabel.textColor = UIColor.gray
        view.addSubview(contributionLabel)
        
        // Game Name Label
        gameNameLabel.numberOfLines = 0
        gameNameLabel.text = "Kenny \nGame"
        gameNameLabel.font = UIFont(name: "Copperplate", size: 62)
        gameNameLabel.textAlignment = .center
        gameNameLabel.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.14, width: screenWidth * 0.8, height: screenHeight * 0.2)
        gameNameLabel.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        gameNameLabel.textColor = UIColor(displayP3Red: 0.0, green: 0.5, blue: 0.3, alpha: 1.0)
        view.addSubview(gameNameLabel)
        
        // Slider for speed
        speedLabel.text = "Speed: "
        speedLabel.font = UIFont(name: "Copperplate", size: 16)
        speedLabel.textAlignment = .center
        speedLabel.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.56, width: screenWidth * 0.8, height: screenHeight * 0.2)
        view.addSubview(speedLabel)
        
        // Start Button
        startButton.setTitle("Start", for: .normal)
        startButton.frame.size = CGSize(width: 35.0, height: 35.0)
        startButton.setTitleColor(UIColor.black, for: .normal)
        startButton.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.75, width: screenWidth * 0.8, height: screenHeight * 0.2)
        startButton.addTarget(self, action: #selector(self.startButtonPressed), for: .touchUpInside)
        view.addSubview(startButton)
    }

    @objc func startButtonPressed(){
        performSegue(withIdentifier: "toGameSegue", sender: nil)
    }
    
    @IBAction func slider(_ sender: UISlider) {
        speed = Double(sender.value)
        if speed < 0.1{
            speed = 0.1 }
        else if speed > 0.9{
            speed = 0.9 }
        // To learn where the slider is
        // let _thumbRect: CGRect = sender.thumbRect(forBounds: sender.bounds, trackRect: sender.trackRect(forBounds: sender.bounds), value: sender.value)
        // let thumbRect: CGRect = view.convert(_thumbRect, from: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameSegue"{
            let destinstion = segue.destination as! gameVC
            destinstion.gameSpeed = speed
        }
    }
}
